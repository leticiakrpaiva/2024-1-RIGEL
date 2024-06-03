from django import forms

class RouteForm(forms.Form):
    start = forms.CharField(label='Starting Point', max_length=100)
    end = forms.CharField(label='Destination', max_length=100)
    rate = forms.DecimalField(label='Rate per km', max_digits=10, decimal_places=2)
