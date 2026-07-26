from django.db import models

# Create your models here.
class hotelDetails(models.Model):
    name = models.CharField(max_length=150,blank=True,null=True)
    address = models.CharField(max_length=150,blank=True,null=True)
    price = models.DecimalField(max_digits=10,decimal_places=2,blank=True,null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    def __str__(self):
        return self.name