from django.shortcuts import render
from django.conf import settings
from .forms import RouteForm

def index(request):
    form = RouteForm()
    context = {
        'form': form,
        'google_maps_api_key': settings.GOOGLE_MAPS_API_KEY
    }

    return render(request, 'maps/index.html', context)
