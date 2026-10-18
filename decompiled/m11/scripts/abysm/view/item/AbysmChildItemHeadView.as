package abysm.view.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mainBar.StripView;
   import managers.ChildManager;
   import mvc.module.children.ChildData;
   import mvc.module.children.ChildModel;
   import mvc.module.outyard.AbysmChildInfo;
   import mvc.module.outyard.AbysmModel;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.OutyardManager;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.GameDrag;
   import yishi.view.community.BaseIconView;
   
   public class AbysmChildItemHeadView extends Sprite implements Disposeable
   {
      
      private var _back:Bitmap;
      
      private var _childIcon:BaseIconView;
      
      private var _posImages:ScaleFrameImage;
      
      private var _maskBit:Bitmap;
      
      private var _pos:int;
      
      private var _info:AbysmChildInfo;
      
      private var _childStrip:StripView;
      
      public function AbysmChildItemHeadView(param1:int)
      {
         _pos = param1;
         super();
         initView();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.abysm.itemBack");
         _childIcon = ComponentFactory.Instance.creatCustomObject("abysm.childIcon");
         _posImages = ComponentFactory.Instance.creatComponentByStylename("abysm.childHeadImages");
         _maskBit = ComponentFactory.Instance.creatBitmap("asset.abysm.itemMask");
         _childStrip = ComponentFactory.Instance.creatCustomObject("abysm.ChildrenIconStrip");
         _childStrip.setHitArea(0,0,45,45);
         _childStrip.buttonMode = true;
         addChild(_back);
         addChild(_childIcon);
         addChild(_posImages);
         addChild(_maskBit);
         addChild(_childStrip);
      }
      
      public function get info() : AbysmChildInfo
      {
         return _info;
      }
      
      public function set info(param1:AbysmChildInfo) : void
      {
         refreshView();
         _info = param1;
         if(!_info)
         {
            return;
         }
         var _loc3_:ChildData = model.getChildById(_info.childId);
         if(!_loc3_)
         {
            return;
         }
         _childStrip.tipData = _loc3_;
         _posImages.visible = true;
         var _loc2_:ChildTempInfo = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_loc3_.job,_loc3_.growthGrade);
         if(_loc2_)
         {
            _childIcon.visible = true;
            _childIcon.icon = PathManager.info.ResourcePath + "icon" + _loc2_.Icon;
         }
         refreshState();
         this.addEventListener("mouseDown",__clickHandler);
      }
      
      private function refreshView() : void
      {
         removeEvent();
         _childStrip.tipData = null;
         _childIcon.visible = false;
         _posImages.visible = false;
         _maskBit.visible = false;
      }
      
      private function refreshState() : void
      {
         var _loc1_:int = 4 - abysmInfo.sealNum;
         if(_pos == 0)
         {
            _posImages.setFrame(1);
         }
         else if(_pos == 1)
         {
            if(_loc1_ <= _pos)
            {
               _posImages.setFrame(5);
               _maskBit.visible = true;
            }
            else
            {
               _posImages.setFrame(2);
            }
         }
         else if(_pos == 2)
         {
            if(_loc1_ <= _pos)
            {
               _posImages.setFrame(6);
               _maskBit.visible = true;
            }
            else
            {
               _posImages.setFrame(3);
            }
         }
         else if(_pos == 3)
         {
            if(_loc1_ <= _pos)
            {
               _posImages.setFrame(7);
               _maskBit.visible = true;
            }
            else
            {
               _posImages.setFrame(4);
            }
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         starItemDrag();
      }
      
      private function starItemDrag() : void
      {
         if(!_info)
         {
            return;
         }
         var _loc2_:DisplayObject = getDragIconObj();
         if(!_loc2_)
         {
            return;
         }
         var _loc1_:GameDrag = DragManager.getInstance().starDrag(this,{
            "icon":_loc2_,
            "type":"down"
         });
         _loc1_.onDrop = onDragStop;
         _loc1_.dropChecks = [AbysmChildItemHeadView,Frame,stage];
         onStartDrag(_loc1_);
         filters = [UIFilter.getGrayFilter(),UIFilter.getLightingFilter()];
      }
      
      private function onStartDrag(param1:GameDrag) : void
      {
         NotificationManager.instance.sendNotification("START_DRAG",this);
      }
      
      private function getDragIconObj() : DisplayObject
      {
         var _loc3_:Bitmap = null;
         var _loc1_:BitmapData = null;
         var _loc4_:Bitmap = null;
         var _loc2_:Sprite = null;
         if(_childIcon)
         {
            _loc3_ = ComponentFactory.Instance.creatBitmap("asset.core.DragIconBack");
            _loc1_ = new BitmapData(_childIcon.content.width / _childIcon.content.scaleX,_childIcon.content.height / _childIcon.content.scaleY,true,0);
            _loc1_.draw(_childIcon.content);
            _loc3_.width = _loc1_.width + 4;
            _loc3_.height = _loc1_.height + 4;
            _loc4_ = new Bitmap(_loc1_);
            _loc4_.x = _loc4_.y = 2;
            _loc2_ = new Sprite();
            _loc2_.addChild(_loc3_);
            _loc2_.addChild(_loc4_);
            return _loc2_;
         }
         return null;
      }
      
      private function onDragStop(param1:GameDrag) : void
      {
         var _loc3_:AbysmChildItemHeadView = null;
         var _loc2_:AbysmChildInfo = null;
         if(param1.dropTarget != this)
         {
            if(param1.dropTarget is AbysmChildItemHeadView)
            {
               _loc3_ = param1.dropTarget as AbysmChildItemHeadView;
               _loc2_ = _loc3_.info;
               if(_loc2_)
               {
                  abysmInfo.changePos(_info.pos,_loc2_.pos);
                  OutyardManager.instance.abysmSendInfo(2,abysmInfo.childList);
               }
               param1.stopImmediatePropagation();
            }
            else
            {
               param1.stopImmediatePropagation();
            }
         }
         else
         {
            param1.stopImmediatePropagation();
         }
         filters = [];
      }
      
      private function get model() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      private function get abysmInfo() : AbysmModel
      {
         return OutyardManager.instance.abysmModel;
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("mouseDown",__clickHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_childIcon);
         _childIcon = null;
         ObjectUtils.disposeObject(_posImages);
         _posImages = null;
         ObjectUtils.disposeObject(_maskBit);
         _maskBit = null;
         ObjectUtils.disposeObject(_childStrip);
         _childStrip = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

