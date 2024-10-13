from django.urls import path

from .views import signupfunc, loginfunc, searchfunc, logoutfunc, detailfunc, goodfunc, readfunc, BoardCreate, homefunc, \
    ReadListView

urlpatterns = [
    path('', loginfunc, name='login'),
    path('signup/', signupfunc, name='signup'),  # URLに対応するビュー関数を指定
    path('login/', loginfunc, name='login'),
    path('home/', homefunc, name='home'),
    path('search/', searchfunc, name='search'),
    path('read_list/', ReadListView.as_view(), name='read_list'),
    path('logout/', logoutfunc, name='logout'),
    path('detail/<int:pk>', detailfunc, name="detail"),
    path('good/<int:pk>', goodfunc, name="good"),
    path('read/<int:pk>/', readfunc, name="read"),
    path('create/', BoardCreate.as_view(), name="create"),
]