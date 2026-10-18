package remotepet.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.RemotePetManager;
   import mvc.module.pet.PetData;
   import mvc.module.remotepet.RemotePetModel;
   import yishi.filter.UIFilter;
   import yishi.manager.DragManager;
   import yishi.utils.GameDrag;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class RemotePetHeadItemView extends Component
   {
      
      private var _pos:int;
      
      private var _data:PetData;
      
      private var _headBack:Image;
      
      private var _addImg:Bitmap;
      
      private var _friendText:FilterFrameText;
      
      private var _headIcon:BaseIconView;
      
      private var _deleteBtn:BaseButton;
      
      private var _cannotDelete:Boolean = false;
      
      public function RemotePetHeadItemView(param1:int = 0)
      {
         _pos = param1;
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _headBack = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetHeadItemView.headBack");
         addChild(_headBack);
         if(_pos == 7)
         {
            _friendText = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetHeadItemView.friendText");
            _friendText.text = LanguageMgr.GetTranslation("remotepet.RemotePetHeadItemView.friendText");
            addChild(_friendText);
         }
         else
         {
            _addImg = ComponentFactory.Instance.creatBitmap("asset.remotepet.headAdd");
            addChild(_addImg);
         }
         _headIcon = ComponentFactory.Instance.creatCustomObject("remotepet.RemotePetHeadItemView.headIcon");
         _deleteBtn = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetHeadItemView.closeBtn");
         addChild(_headIcon);
         addChild(_deleteBtn);
         _deleteBtn.visible = false;
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
         if(_data)
         {
            refresh();
         }
         if(!_cannotDelete)
         {
            _deleteBtn.enable = true;
         }
      }
      
      public function disableDelete() : void
      {
         _cannotDelete = true;
         _deleteBtn.visible = false;
      }
      
      private function clean() : void
      {
         _headIcon.icon = null;
         _headIcon.tipData = null;
      }
      
      public function refresh() : void
      {
         if(_data)
         {
            if(_data.remoteHp == 0)
            {
               this.filters = [UIFilter.getBlackFilter()];
            }
            else
            {
               this.filters = [];
            }
            _headIcon.tipData = _data;
            _headIcon.icon = IconFactory.getPetHeadItemIcon(_data.templateId);
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
         addEventListener("mouseDown",__mouseClickHandler);
         if(_deleteBtn)
         {
            _deleteBtn.addEventListener("mouseDown",__deleteBtnHandler);
         }
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         _deleteBtn.visible = false;
      }
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
         if(_data && !_cannotDelete)
         {
            _deleteBtn.visible = true;
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseDown",__mouseClickHandler);
         if(_deleteBtn)
         {
            _deleteBtn.removeEventListener("mouseDown",__deleteBtnHandler);
         }
      }
      
      private function __deleteBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:Array = null;
         if(!_data)
         {
            return;
         }
         var _loc3_:PetData = _data;
         model.petListInfo.petList[_pos] = null;
         data = null;
         if(_pos <= 3)
         {
            _loc2_ = [];
            _loc2_.push(_loc3_);
            _loc2_.push(null);
            model.petChange(_loc2_);
         }
         model.commit();
         LayerManager.Instance.clearGameMenuLayer();
         param1.stopPropagation();
      }
      
      private function __mouseClickHandler(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
         if(DragManager.getInstance().isDraging)
         {
            return;
         }
         var _loc3_:DisplayObject = getDragIconObj();
         if(!_loc3_)
         {
            return;
         }
         var _loc2_:GameDrag = DragManager.getInstance().starDrag(this,{
            "icon":_loc3_,
            "type":"down"
         });
         _loc2_.onDrop = onDragStop;
         _loc2_.dropChecks = [RemotePetHeadItemView,Stage];
      }
      
      private function getDragIconObj() : DisplayObject
      {
         var _loc1_:BitmapData = new BitmapData(_headIcon.iconWidth / _headIcon.scaleX,_headIcon.iconHeight / _headIcon.scaleY,true,0);
         _loc1_.draw(_headIcon);
         return new Bitmap(_loc1_);
      }
      
      private function onDragStop(param1:GameDrag) : void
      {
         var _loc2_:RemotePetHeadItemView = null;
         if(param1.dropTarget != this)
         {
            if(param1.dropTarget is RemotePetHeadItemView)
            {
               _loc2_ = param1.dropTarget as RemotePetHeadItemView;
               if(this.pos > 3 && _loc2_.pos <= 3 || this.pos <= 3 && _loc2_.pos > 3)
               {
                  swap(this,_loc2_);
               }
               param1.stopImmediatePropagation();
            }
            else
            {
               param1.stopImmediatePropagation();
            }
         }
         param1.stopImmediatePropagation();
      }
      
      private function swap(param1:RemotePetHeadItemView, param2:RemotePetHeadItemView) : void
      {
         if(param1.pos == 7 || param2.pos == 7)
         {
            return;
         }
         var _loc3_:PetData = param2.data;
         param2.data = param1.data;
         model.petListInfo.petList[param2.pos] = param1.data;
         param2.refresh();
         param1.data = _loc3_;
         model.petListInfo.petList[param1.pos] = _loc3_;
         param1.refresh();
         var _loc4_:Array = [];
         if(param1.pos > 3)
         {
            _loc4_ = [model.petListInfo.petList[param1.pos],model.petListInfo.petList[param2.pos]];
         }
         else
         {
            _loc4_ = [model.petListInfo.petList[param2.pos],model.petListInfo.petList[param1.pos]];
         }
         model.petChange(_loc4_);
      }
      
      private function get model() : RemotePetModel
      {
         return RemotePetManager.instance.model;
      }
      
      public function get pos() : int
      {
         return _pos;
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_headBack);
         _headBack = null;
         ObjectUtils.disposeObject(_addImg);
         _addImg = null;
         ObjectUtils.disposeObject(_friendText);
         _friendText = null;
         ObjectUtils.disposeObject(_headIcon);
         _headIcon = null;
         ObjectUtils.disposeObject(_deleteBtn);
         _deleteBtn = null;
         ObjectUtils.disposeAllChildren(this);
         _data = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uintView();
         super.dispose();
      }
   }
}

