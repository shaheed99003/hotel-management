from rest_framework import serializers
from .models import hotelDetails

class hotelDetailsSerializer(serializers.ModelSerializer):
    class Meta:
        model = hotelDetails
        fields = '__all__' 