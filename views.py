# views.py
from django.shortcuts import render
from .models import hotelDetails
from .serializers import hotelDetailsSerializer
from rest_framework import viewsets

# Create your views here.

class hotelDetailsViewSet(viewsets.ModelViewSet):
    queryset = hotelDetails.objects.all().order_by('-created_at')
    serializer_class = hotelDetailsSerializer