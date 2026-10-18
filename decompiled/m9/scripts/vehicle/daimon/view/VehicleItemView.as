package vehicle.daimon.view
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mvc.module.vehicle.DaimonModel;
   import yishi.datas.templates.VehicleObjectTempInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PathManager;
   
   public class VehicleItemView extends Component implements ISelectable
   {
      
      private var _bg:Bitmap;
      
      private var _nameTxt:FilterFrameText;
      
      private var _lock:Bitmap;
      
      private var _data:VehicleObjectTempInfo;
      
      private var _isOpen:Boolean;
      
      private var _selected:Boolean;
      
      private var _locked:Boolean;
      
      private var _model:DaimonModel = FrameControllerManager.instance.vehicleDaimonController.model;
      
      private var _over:ScaleFrameImage;
      
      private var _vehiclemc:Bitmap;
      
      private var _contentSprite:Sprite;
      
      private var _mask:Shape;
      
      public function VehicleItemView()
      {
         super();
         initView();
         data = null;
         this.mouseChildren = false;
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.daimon.DaimonItemBg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("daimonItemView.NameTxt");
         _lock = ComponentFactory.Instance.creatBitmap("asset.wildsoul.Lock");
         _over = ComponentFactory.Instance.creatComponentByStylename("VehicleItemView.OverImage");
         _mask = new Shape();
         _contentSprite = new Sprite();
         _contentSprite.x = 78;
         _contentSprite.y = 100;
         _lock.x = 55;
         _lock.y = 45;
         _mask.graphics.beginFill(0);
         _mask.graphics.drawRect(0,0,137,110);
         _mask.graphics.endFill();
         _mask.x = 4;
         _mask.y = 5;
         addChild(_bg);
         addChild(_contentSprite);
         addChild(_nameTxt);
         addChild(_over);
         _over.visible = false;
         this.width = _bg.width;
         this.height = _bg.height;
      }
      
      private function unitView() : void
      {
         ObjectUtils.disposeObject(_lock);
         _lock = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         _contentSprite = null;
         if(_vehiclemc)
         {
            _vehiclemc.bitmapData.dispose();
            _vehiclemc = null;
         }
      }
      
      public function mouseOver() : void
      {
         if(selected || locked)
         {
            return;
         }
         _over.visible = true;
         _over.setFrame(1);
      }
      
      public function mouseOut() : void
      {
         if(selected || locked)
         {
            return;
         }
         _over.visible = false;
         _over.setFrame(1);
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__onCompleteHandler);
         unitView();
         super.dispose();
      }
      
      public function get data() : VehicleObjectTempInfo
      {
         return _data;
      }
      
      public function set data(param1:VehicleObjectTempInfo) : void
      {
         if(_data && _data == param1)
         {
            if(_model.isActive(_data.TemplateId))
            {
               unlock();
            }
            else
            {
               lock();
            }
            return;
         }
         removeEvent();
         _data = param1;
         this.tipData = null;
         lock();
         ObjectUtils.disposeAllChildren(_contentSprite);
         if(_mask && _mask.parent)
         {
            _mask.parent.removeChild(_mask);
         }
         if(_data)
         {
            _nameTxt.text = _data.TemplateName;
            if(_model.isActive(_data.TemplateId))
            {
               unlock();
            }
            else
            {
               addEvent();
            }
            loaderReource();
            this.tipData = _data;
         }
         else
         {
            _nameTxt.text = "";
            if(_vehiclemc && _vehiclemc.bitmapData)
            {
               _vehiclemc.bitmapData.dispose();
            }
         }
      }
      
      private function addEvent() : void
      {
         this.addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("click",__clickHandler);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
      }
      
      private function loaderReource() : void
      {
         var _loc1_:String = PathManager.getVehicleShowAvatarPath(_data.Avatar);
         if(_loc1_ == "")
         {
            return;
         }
         LoaderManagerII.instance.load(_loc1_,2,8,__onCompleteHandler);
      }
      
      private function __onCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(isDie)
         {
            return;
         }
         ObjectUtils.disposeAllChildren(_contentSprite);
         _vehiclemc = param2 as Bitmap;
         if(_vehiclemc)
         {
            _contentSprite.addChild(_vehiclemc);
            _vehiclemc.scaleX = 0.6;
            _vehiclemc.scaleY = 0.6;
            _loc3_ = 168;
            _loc4_ = 168;
            _vehiclemc.x = -(_vehiclemc.width >> 1);
            _vehiclemc.y = -(_vehiclemc.height - 37);
            _vehiclemc.mask = _mask;
            addChild(_mask);
         }
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
      
      public function set isOpen(param1:Boolean) : void
      {
         _isOpen = param1;
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         if(_selected)
         {
            _over.visible = true;
            _over.setFrame(2);
         }
         else
         {
            _over.visible = false;
         }
      }
      
      public function get locked() : Boolean
      {
         return _locked;
      }
      
      private function lock() : void
      {
         addChild(_lock);
         _locked = true;
         this.filters = [UIFilter.getGrayFilter()];
      }
      
      private function unlock() : void
      {
         _lock.parent && removeChild(_lock);
         _locked = false;
         this.filters = [];
      }
   }
}

