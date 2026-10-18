package childarena
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import managers.ChildManager;
   import mvc.module.children.ChildArenaModel;
   import mvc.module.children.ChildCommonFormationInfo;
   import mvc.module.children.ChildData;
   import mvc.module.children.ChildModel;
   import mvc.module.children.ChildSender;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.GameDrag;
   import yishi.view.community.BaseIconView;
   
   public class ChildArenaHeadItemView extends Component
   {
      
      private var back:Bitmap;
      
      private var childIcon:BaseIconView;
      
      private var posImages:ScaleFrameImage;
      
      private var _data:ChildCommonFormationInfo;
      
      public function ChildArenaHeadItemView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatBitmap("asset.ChildArenaHeadItemView.itemBack");
         childIcon = ComponentFactory.Instance.creatCustomObject("ChildArenaHeadItemView.childIcon");
         posImages = ComponentFactory.Instance.creatComponentByStylename("ChildArenaHeadItemView.posImages");
         addChild(back);
         addChild(childIcon);
         addChild(posImages);
         posImages.setFrame(1);
      }
      
      public function get data() : ChildCommonFormationInfo
      {
         return _data;
      }
      
      public function set data(param1:ChildCommonFormationInfo) : void
      {
         _data = param1;
         clean();
         if(!_data)
         {
            return;
         }
         var _loc3_:ChildData = model.getChildById(_data.childId);
         if(!_loc3_)
         {
            return;
         }
         var _loc2_:ChildTempInfo = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_loc3_.job,_loc3_.growthGrade);
         if(_loc2_)
         {
            childIcon.visible = true;
            childIcon.icon = PathManager.info.ResourcePath + "icon" + _loc2_.Icon;
            this.tipData = _loc3_;
         }
         posImages.visible = true;
         posImages.setFrame(_data.standPos);
         this.tipData = _loc3_;
         this.addEventListener("mouseDown",__clickHandler);
      }
      
      private function clean() : void
      {
         removeEvent();
         childIcon.visible = false;
         posImages.visible = false;
         this.tipData = null;
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         starItemDrag();
      }
      
      private function starItemDrag() : void
      {
         if(!_data)
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
         _loc1_.dropChecks = [ChildArenaHeadItemView,Frame,stage];
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
         if(childIcon)
         {
            _loc3_ = ComponentFactory.Instance.creatBitmap("asset.core.DragIconBack");
            _loc1_ = new BitmapData(childIcon.content.width / childIcon.content.scaleX,childIcon.content.height / childIcon.content.scaleY,true,0);
            _loc1_.draw(childIcon.content);
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
         var _loc3_:ChildArenaHeadItemView = null;
         var _loc2_:ChildCommonFormationInfo = null;
         if(param1.dropTarget != this)
         {
            if(param1.dropTarget is ChildArenaHeadItemView)
            {
               _loc3_ = param1.dropTarget as ChildArenaHeadItemView;
               _loc2_ = _loc3_.data;
               if(_loc2_)
               {
                  arenaModel.changePos(_data,_loc2_);
                  ChildSender.setChildArenaPos(arenaModel.childAreanFromationList);
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
      
      private function get arenaModel() : ChildArenaModel
      {
         return ChildManager.instance.arenaModel;
      }
      
      private function get model() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("mouseDown",__clickHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(childIcon);
         childIcon = null;
         ObjectUtils.disposeObject(posImages);
         posImages = null;
         super.dispose();
      }
   }
}

