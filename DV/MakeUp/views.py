from django.shortcuts import render, render_to_response, get_object_or_404

# Create your views here.
from django.http import HttpResponse, HttpResponseRedirect
from django.template import RequestContext, loader
from django.core.urlresolvers import reverse
from .models import Image_Raw, Image_New
import matlab.engine
#from django.views.generic import FormView, DetailView, ListView
from .form import UploadImageForm
from .models import Image_Raw


eng = matlab.engine.start_matlab()
#from .forms import DocumentForm

    
'''def index(request):
    image_list = Image_Raw.objects.order_by('name','pk')
    form_class = UploadImageForm
    def form_valid(self, form):
        image = Image_Raw(
            file=self.get_form_kwargs().get('files')['image'])
        image.save()
        self.id = image.id

        return HttpResponseRedirect(self.get_success_url())

    def get_success_url(self):
        return reverse('image', kwargs={'pk': self.id}

    return render(request, 'MakeUp/index.html', {'image_list': image_list, 'image': image})'''


def list(request):
    if request.method == 'POST':
        form = UploadImageForm(request.POST, request.FILES)
        if form.is_valid():
            new_image = Image_Raw(name = request.POST.get('name'), file = request.FILES['image'])
            new_image.save()
            
            return HttpResponseRedirect(reverse('MakeUp.views.list'))
    else:
        form = UploadImageForm()
        
    
    image_list = Image_Raw.objects.all()
    
    return render_to_response(
        'MakeUp/list.html',
        {'image_list': image_list, 'form': form},
        context_instance=RequestContext(request)
    )
        
    
    
    
def detail(request, image_id):
    image = get_object_or_404(Image_Raw, pk=image_id)
    return render(request, 'MakeUp/detail.html', {'image': image})



def choice(request, image_id):
    selected_choice = request.POST['choice']
    image = get_object_or_404(Image_Raw, pk = image_id)
    if selected_choice == "Addon":
        x = eng.triarea(1.0,5.0)
    elif selected_choice == "Removal":
        x = eng.imfinfo(image.file.url)
    elif selected_choice == "Suggestion":
        x = eng.makeupremove(image.file.url)
    else:
        x = "error"
    return render(request, 'MakeUp/choice.html', {'x': x, 'image': image})
    
    
    
    
    
        