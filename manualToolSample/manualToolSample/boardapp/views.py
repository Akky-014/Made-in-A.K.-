from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.shortcuts import render, redirect
from django.contrib.auth.models import User
from django.utils.decorators import method_decorator
from django.views.generic import CreateView, ListView
from django.urls import reverse_lazy

from .models import BoardModel, EventModel


# Create your views here.
def signupfunc(request):
    if request.method == 'POST':
        username2 = request.POST['username']
        password2 = request.POST['password']
        try:
            User.objects.get(username=username2)
            return render(request, 'signup.html', {'error': 'このユーザーは登録されています'})
        except:
            user = User.objects.create_user(username2, '', password2)
            return render(request, 'signup.html', {'some': 100})
    return render(request, 'signup.html', {'some': 100})

def loginfunc(request):
    if request.method == 'POST':
        username2 = request.POST['username']
        password2 = request.POST['password']
        user = authenticate(username=username2, password=password2)
        if user is not None:
            login(request, user)
            return redirect('home')
        else:
            return redirect('login')
    return render(request, 'login.html')

@login_required
def listfunc(request):
    object_list = BoardModel.objects.all().order_by('-id')
    return render(request, 'list.html', {'object_list': object_list})

def logoutfunc(request):
    logout(request)
    return redirect('login')

@login_required
def detailfunc(request, pk):
    object = EventModel.objects.get(pk=pk)
    return render(request, 'detail.html', {'object': object})

@login_required
def homefunc(request):
    return render(request, 'home.html')

@login_required
def searchfunc(request):
    return render(request, 'search.html')

def goodfunc(request, pk):
    post = BoardModel.objects.get(pk=pk)
    post.good = post.good + 1
    post.save()
    return redirect('read_list')

def readfunc(request, pk):
    post = BoardModel.objects.get(pk=pk)
    post2 = request.user.get_username()
    if post2 in post.readtext:
        return redirect('read_list')
    else:
        post.read += 1
        post.readtext = post.readtext + ' ' + post2
        post.save()
        return redirect('read_list')

@method_decorator(login_required, name='dispatch')
class ReadListView(ListView):
    model = EventModel
    template_name = 'list.html'
    context_object_name = 'object_list'

    def get_queryset(self):
        return EventModel.objects.all().order_by('-id')

class BoardCreate(CreateView):
    template_name = 'create.html'
    model = BoardModel
    fields = ('title', 'content', 'author', 'images')
    success_url = reverse_lazy('read_list')

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        print("BoardCreate instance is being initialized")

    def get_queryset(self):
        return EventModel.objects.all().order_by('-id')  # ここでデータを新しい順に並べる