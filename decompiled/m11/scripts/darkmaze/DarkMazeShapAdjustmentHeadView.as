package darkmaze
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import managers.DarkMazeManager;
   import mvc.module.children.ChildData;
   import mvc.module.darkmaze.DarkMazeChildPosInfo;
   import mvc.module.darkmaze.DarkMazeModel;
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
   
   public class DarkMazeShapAdjustmentHeadView extends Component implements IManualSize
   {
      
      private var _border:ScaleBitmapImage;
      
      private var _back:MutipleImage;
      
      private var _icon:BaseIconView;
      
      private var _nameTxt:FilterFrameText;
      
      private var _battleValueTxt:FilterFrameText;
      
      private var _hasDieTxt:FilterFrameText;
      
      private var dragView:DarkMazeShapAdjustmentItemView;
      
      private var _sprite:Sprite;
      
      private var _hpMaxImg:Image;
      
      private var _hpMinImg:Image;
      
      private var _mask:Shape;
      
      private var _enable:Boolean = false;
      
      private var _model:DarkMazeModel;
      
      private var _data:ChildData;
      
      private var _currentHp:int;
      
      private var _totalHp:int;
      
      private var _fightValue:int;
      
      private var _rect:Rectangle;
      
      public function DarkMazeShapAdjustmentHeadView()
      {
         super();
         _model = DarkMazeManager.instance.model;
         initView();
         this.mouseChildren = false;
      }
      
      private function initView() : void
      {
         _border = ComponentFactory.Instance.creatComponentByStylename("DarkMazeShapAdjustmentHeadView.border");
         _back = ComponentFactory.Instance.creatComponentByStylename("DarkMazeShapAdjustmentHeadView.back");
         _icon = ComponentFactory.Instance.creatCustomObject("darkMazeCommonItemView.iconView");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("DarkMazeShapAdjustmentHeadView.nameTxt");
         _battleValueTxt = ComponentFactory.Instance.creatComponentByStylename("DarkMazeShapAdjustmentHeadView.battleValueTxt");
         _hasDieTxt = ComponentFactory.Instance.creatComponentByStylename("DarkMazeShapAdjustmentHeadView.hasDieTxt");
         _hpMaxImg = ComponentFactory.Instance.creatComponentByStylename("darkMazeCommonItemView.hpMaxImg");
         _hpMinImg = ComponentFactory.Instance.creatComponentByStylename("darkMazeCommonItemView.hpMinImg");
         _mask = new Shape();
         _mask.graphics.beginFill(16777215,0);
         _mask.graphics.drawRect(0,0,_hpMaxImg.width,_hpMaxImg.height);
         _mask.graphics.endFill();
         _hpMaxImg.x = _hpMinImg.x = 85;
         _hpMaxImg.y = _hpMinImg.y = 58;
         _icon.x = 15;
         _icon.y = 25;
         _mask.x = _hpMaxImg.x;
         _mask.y = _hpMaxImg.y;
         _hpMaxImg.mask = _mask;
         _sprite = new Sprite();
         _sprite.addChild(_border);
         _sprite.addChild(_back);
         _sprite.addChild(_icon);
         _sprite.addChild(_nameTxt);
         _sprite.addChild(_battleValueTxt);
         _sprite.addChild(_hpMinImg);
         _sprite.addChild(_hpMaxImg);
         _sprite.addChild(_mask);
         addChild(_sprite);
         addChild(_hasDieTxt);
         _hasDieTxt.visible = false;
         _hpMaxImg.visible = true;
         _hpMinImg.visible = true;
         _hasDieTxt.text = LanguageMgr.GetTranslation("darkmaze.DarkMazeShapAdjustmentHeadView.hasDieTxt");
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_battleValueTxt);
         _battleValueTxt = null;
         ObjectUtils.disposeObject(_hasDieTxt);
         _hasDieTxt = null;
         ObjectUtils.disposeObject(_hpMinImg);
         _hpMinImg = null;
         ObjectUtils.disposeObject(_hpMaxImg);
         _hpMaxImg = null;
         ObjectUtils.disposeObject(_mask);
         _mask = null;
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
         var _loc2_:Array = _model.battleArray;
         var _loc5_:int = 0;
         for each(var _loc4_:DarkMazeChildPosInfo in _loc2_)
         {
            if(_loc4_ && _loc4_.childId != 0)
            {
               _loc5_++;
            }
         }
         if(_loc5_ >= 3)
         {
            _loc3_ = LanguageMgr.GetTranslation("PetFormationItemView.posFull");
            MessageTipManager.instance().show(_loc3_);
            return;
         }
         dragView = new DarkMazeShapAdjustmentItemView();
         dragView.data = data;
         dragView.isDrag = true;
         dragView.mouseChildren = dragView.mouseEnabled = false;
         var _loc6_:GameDrag = DragManager.getInstance().starDrag(this,{
            "icon":dragView,
            "type":param1
         });
         _loc6_.data = data;
         _loc6_.onDrop = dragBack;
         _loc6_.dropChecks = [DarkMazeShapAdjustmentItemView,Stage];
         this.enable = false;
         NotificationManager.instance.sendNotification("START_DRAG",this);
      }
      
      private function dragBack(param1:GameDrag) : void
      {
         var _loc2_:DarkMazeShapAdjustmentItemView = null;
         if(param1.dropTarget != param1.dragIcon && param1.dropTarget is DarkMazeShapAdjustmentItemView)
         {
            _loc2_ = param1.dropTarget as DarkMazeShapAdjustmentItemView;
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
      
      public function get enable() : Boolean
      {
         return _enable;
      }
      
      public function set enable(param1:Boolean) : void
      {
         _enable = param1;
         _hpMaxImg.visible = _hpMinImg.visible = true;
         if(_enable && _currentHp != 0)
         {
            _sprite.filters = [];
            _hasDieTxt.filters = [];
         }
         else
         {
            _sprite.filters = [UIFilter.getGrayFilter()];
            _hasDieTxt.filters = [UIFilter.getGrayFilter()];
         }
         if(_currentHp <= 0)
         {
            _hasDieTxt.visible = true;
            _hasDieTxt.filters = [];
            _enable = false;
            _hpMaxImg.visible = _hpMinImg.visible = false;
         }
      }
      
      public function get data() : ChildData
      {
         return _data;
      }
      
      public function set fightValue(param1:int) : void
      {
         _fightValue = param1;
         _battleValueTxt.text = _fightValue.toString();
      }
      
      public function set data(param1:ChildData) : void
      {
         var _loc3_:ChildTempInfo = null;
         var _loc2_:int = 0;
         _data = param1;
         removeEvent();
         if(_data)
         {
            addEvent();
            _nameTxt.text = _data.name;
            _loc3_ = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_data.job,_data.growthGrade);
            _icon.icon = PathManager.info.ResourcePath + "icon" + _loc3_.Icon;
            _loc2_ = _hpMaxImg.width * (_totalHp - _currentHp) / _totalHp;
            _mask.x = _hpMaxImg.x - _loc2_;
         }
      }
      
      public function set totalHp(param1:int) : void
      {
         _totalHp = param1;
      }
      
      public function set currentHp(param1:int) : void
      {
         _currentHp = param1;
      }
      
      public function get viewRectangle() : Rectangle
      {
         if(!_rect)
         {
            _rect = new Rectangle(0,0,160,83);
         }
         return _rect;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uintView();
         if(dragView)
         {
            dragView.dispose();
            dragView = null;
         }
         super.dispose();
         _model = null;
      }
   }
}

