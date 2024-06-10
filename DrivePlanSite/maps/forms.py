from django import forms

class RouteForm(forms.Form):
    start = forms.CharField(label='Ponto de Partida', max_length=100, widget=forms.TextInput(attrs={'class': 'form-control'}))
    end = forms.CharField(label='Destino', max_length=100, widget=forms.TextInput(attrs={'class': 'form-control'}))
    rate = forms.DecimalField(label='Taxa por km', max_digits=10, decimal_places=2, widget=forms.NumberInput(attrs={'class': 'form-control'}))
