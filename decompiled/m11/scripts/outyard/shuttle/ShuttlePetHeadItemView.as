package outyard.shuttle
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import mvc.module.pet.PetData;
   import yishi.filter.UIFilter;
   import yishi.manager.OutyardManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class ShuttlePetHeadItemView extends Component
   {
      
      private var _pos:int;
      
      private var _data:PetData;
      
      private var _brightBmp:Bitmap;
      
      private var _headBack:Image;
      
      private var _addImg:Bitmap;
      
      private var _headIcon:BaseIconView;
      
      private var _greenBar:MovieClip;
      
      private var _cannotDelete:Boolean = false;
      
      public function ShuttlePetHeadItemView(param1:int = 0)
      {
         _pos = param1;
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _brightBmp = ComponentFactory.Instance.creatBitmap("asset.outyard.shuttle.brightItemBmp");
         _headBack = ComponentFactory.Instance.creatComponentByStylename("outyard.RemotePetHeadItemView.headBack");
         _addImg = ComponentFactory.Instance.creatBitmap("asset.outyard.headAdd");
         _headIcon = ComponentFactory.Instance.creatCustomObject("outyard.RemotePetHeadItemView.headIcon");
         _greenBar = ComponentFactory.Instance.creatCustomObject("outyard.PetGreenBar");
         addChild(_brightBmp);
         addChild(_headBack);
         addChild(_addImg);
         addChild(_headIcon);
         addChild(_greenBar);
         _greenBar.gotoAndStop(1);
         _brightBmp.visible = false;
      }
      
      public function get data() : PetData
      {
         return _data;
      }
      
      public function set data(param1:PetData) : void
      {
         if(_data == param1)
         {
            return;
         }
         clean();
         _data = param1;
         refresh();
      }
      
      private function clean() : void
      {
         _headIcon.icon = null;
         _headIcon.tipData = null;
         _greenBar.gotoAndStop(0);
      }
      
      private function get remoteHp() : int
      {
         return OutyardManager.instance.shuttleModel.getRemoteHpById(_data.petId);
      }
      
      public function refresh() : void
      {
         if(_data)
         {
            if(remoteHp == 0)
            {
               this.filters = [UIFilter.getBlackFilter()];
            }
            else
            {
               this.filters = [];
            }
            _headIcon.tipData = _data;
            _headIcon.icon = IconFactory.getPetHeadItemIcon(_data.templateId);
            _greenBar.gotoAndStop(remoteHp);
         }
         else
         {
            this.filters = [];
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("mouseOver",__mouseOverHandler);
         addEventListener("mouseOut",__mouseOutHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOver",__mouseOverHandler);
         removeEventListener("mouseOut",__mouseOutHandler);
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
      }
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
      }
      
      public function get pos() : int
      {
         return _pos;
      }
      
      public function set bright(param1:Boolean) : void
      {
         _brightBmp.visible = param1;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_brightBmp);
         _brightBmp = null;
         ObjectUtils.disposeObject(_headBack);
         _headBack = null;
         ObjectUtils.disposeObject(_addImg);
         _addImg = null;
         ObjectUtils.disposeObject(_headIcon);
         _headIcon = null;
         ObjectUtils.disposeViolentMc(_greenBar);
         _greenBar = null;
         _data = null;
         super.dispose();
      }
   }
}

