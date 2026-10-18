package childformation
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildArenaModel;
   import mvc.module.children.ChildCommonFormationInfo;
   import mvc.module.children.ChildData;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.BaseManager;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.GameDrag;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildCommonFormationHeadView extends Component implements IManualSize
   {
      
      private var _border:ScaleBitmapImage;
      
      private var _back:Image;
      
      private var _icon:BaseIconView;
      
      private var _nameTxt:FilterFrameText;
      
      private var _gradeTxt:FilterFrameText;
      
      private var _enable:Boolean = true;
      
      private var _data:ChildData;
      
      private var _formationType:int;
      
      private var dragView:ChildCommonFormationItemView;
      
      public function ChildCommonFormationHeadView()
      {
         super();
         initView();
         this.mouseChildren = false;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,154,63);
      }
      
      private function initView() : void
      {
         _border = ComponentFactory.Instance.creatComponentByStylename("ChildFormationHeadView.border");
         _back = ComponentFactory.Instance.creatComponentByStylename("ChildFormationHeadView.back");
         _icon = ComponentFactory.Instance.creatCustomObject("ChildFormationHeadView.icon");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("ChildFormationHeadView.nameTxt");
         _gradeTxt = ComponentFactory.Instance.creatComponentByStylename("ChildFormationHeadView.gradeTxt");
         addChild(_border);
         addChild(_back);
         addChild(_icon);
         addChild(_nameTxt);
         addChild(_gradeTxt);
      }
      
      private function addEvent() : void
      {
         this.addEventListener("mouseDown",__mouseDownHandler);
         this.addEventListener("mouseUp",__mouseUpHandler);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("mouseDown",__mouseDownHandler);
         this.removeEventListener("mouseUp",__mouseUpHandler);
         this.removeEventListener("mouseMove",__mouseMoveHandler);
      }
      
      private function __mouseDownHandler(param1:MouseEvent) : void
      {
         if(!enable)
         {
            return;
         }
         this.addEventListener("mouseMove",__mouseMoveHandler);
      }
      
      private function __mouseMoveHandler(param1:MouseEvent) : void
      {
         if(!enable)
         {
            return;
         }
         this.removeEventListener("mouseMove",__mouseMoveHandler);
         if(DragManager.getInstance().isDraging)
         {
            return;
         }
         clearTimeout(BaseManager.delayId);
         BaseManager.delayId = setTimeout(beginDrag,100,"down");
      }
      
      private function __mouseUpHandler(param1:MouseEvent) : void
      {
         if(!enable)
         {
            return;
         }
         this.removeEventListener("mouseMove",__mouseMoveHandler);
         if(DragManager.getInstance().isDraging)
         {
            return;
         }
         clearTimeout(BaseManager.delayId);
         BaseManager.delayId = setTimeout(beginDrag,100,"click");
      }
      
      private function beginDrag(param1:String) : void
      {
         var _loc3_:String = null;
         var _loc2_:Array = ChildIdArr;
         var _loc4_:int = 0;
         for each(var _loc5_:int in _loc2_)
         {
            if(_loc5_ > 0)
            {
               _loc4_++;
            }
         }
         if(_loc4_ >= 4)
         {
            _loc3_ = LanguageMgr.GetTranslation("childpve.ChildFormationFrame.posFull");
            MessageTipManager.instance().show(_loc3_);
            return;
         }
         dragView = new ChildCommonFormationItemView();
         dragView.data = data;
         dragView.isDrag = true;
         dragView.mouseChildren = dragView.mouseEnabled = false;
         var _loc6_:GameDrag = DragManager.getInstance().starDrag(this,{
            "icon":dragView,
            "type":param1
         });
         _loc6_.data = data;
         _loc6_.onDrop = dragBack;
         _loc6_.dropChecks = [ChildCommonFormationItemView,Stage];
         this.enable = false;
         NotificationManager.instance.sendNotification("START_DRAG",this);
      }
      
      private function dragBack(param1:GameDrag) : void
      {
         var _loc2_:ChildCommonFormationItemView = null;
         if(param1.dropTarget != param1.dragIcon && param1.dropTarget is ChildCommonFormationItemView)
         {
            _loc2_ = param1.dropTarget as ChildCommonFormationItemView;
         }
         if(param1.dragIcon)
         {
            ObjectUtils.disposeObject(param1.dragIcon);
         }
         dragView = null;
         if(_loc2_)
         {
            _loc2_.data = param1.data as ChildData;
         }
         else
         {
            this.enable = true;
         }
         NotificationManager.instance.sendNotification("END_DRAG",this);
      }
      
      public function get formationType() : int
      {
         return _formationType;
      }
      
      public function set formationType(param1:int) : void
      {
         _formationType = param1;
      }
      
      public function get data() : ChildData
      {
         return _data;
      }
      
      public function set data(param1:ChildData) : void
      {
         var _loc2_:ChildTempInfo = null;
         _data = param1;
         removeEvent();
         if(_data)
         {
            addEvent();
            _nameTxt.text = _data.name;
            _gradeTxt.text = LanguageMgr.GetTranslation("public.level2",_data.growthGrade);
            _loc2_ = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_data.job,_data.growthGrade);
            _icon.icon = PathManager.info.ResourcePath + "icon" + _loc2_.Icon;
         }
         else
         {
            _icon.icon = null;
            _nameTxt.text = "";
            _gradeTxt.text = "";
         }
      }
      
      public function get enable() : Boolean
      {
         return _enable;
      }
      
      public function set enable(param1:Boolean) : void
      {
         if(_enable == param1)
         {
            return;
         }
         _enable = param1;
         if(_enable)
         {
            filters = null;
         }
         else
         {
            filters = [UIFilter.getGrayFilter()];
         }
      }
      
      private function get formationChildList() : Array
      {
         if(formationType == 1)
         {
            return arenaModel.childAreanFromationList;
         }
         return [];
      }
      
      public function get ChildIdArr() : Array
      {
         var _loc2_:Array = [];
         for each(var _loc1_:ChildCommonFormationInfo in formationChildList)
         {
            _loc2_.push(_loc1_.childId);
         }
         return _loc2_;
      }
      
      private function get arenaModel() : ChildArenaModel
      {
         return ChildManager.instance.arenaModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_gradeTxt);
         _gradeTxt = null;
         ObjectUtils.disposeObject(dragView);
         dragView = null;
         super.dispose();
      }
   }
}

