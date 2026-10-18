package monopoly.view
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import managers.PetChallengeManager;
   import mvc.module.pet.PetData;
   import mvc.module.petchallenge.PetChallengeModel;
   import yishi.filter.UIFilter;
   import yishi.manager.BaseManager;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.GameDrag;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class MonopolyPetFormationPetHeadView extends Component implements IManualSize
   {
      
      private var _border:ScaleBitmapImage;
      
      private var _back:Image;
      
      private var _icon:BaseIconView;
      
      private var _nameTxt:FilterFrameText;
      
      private var _gradeTxt:FilterFrameText;
      
      private var _stateFlag:ScaleFrameImage;
      
      private var _model:PetChallengeModel = PetChallengeManager.instance.model;
      
      private var dragView:MonopolyPetFormationItemView;
      
      private var _data:PetData;
      
      private var _enable:Boolean = true;
      
      private var _rect:Rectangle;
      
      public function MonopolyPetFormationPetHeadView()
      {
         super();
         initView();
         this.mouseChildren = false;
      }
      
      private function initView() : void
      {
         _border = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyPetFormationPetHeadView.border");
         _back = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyPetFormationPetHeadView.back");
         _icon = ComponentFactory.Instance.creatCustomObject("monopoly.MonopolyPetFormationPetHeadView.icon");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyPetFormationPetHeadView.nameTxt");
         _gradeTxt = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyPetFormationPetHeadView.gradeTxt");
         _stateFlag = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyPetFormationPetHeadView.stateFlag");
         _stateFlag.setFrame(1);
         _stateFlag.visible = false;
         _stateFlag.tipData = LanguageMgr.GetTranslation("pet.list.PetListItemView.enterWarTip");
         addChild(_border);
         addChild(_back);
         addChild(_icon);
         addChild(_nameTxt);
         addChild(_gradeTxt);
         addChild(_stateFlag);
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
         ObjectUtils.disposeObject(_gradeTxt);
         _gradeTxt = null;
         ObjectUtils.disposeObject(_stateFlag);
         _stateFlag = null;
         ObjectUtils.disposeAllChildren(this);
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
         var _loc2_:Array = _model.petChallengeFormationOfArray;
         var _loc4_:int = 0;
         for each(var _loc5_:int in _loc2_)
         {
            if(_loc5_ >= 0)
            {
               _loc4_++;
            }
         }
         if(_loc4_ >= 3)
         {
            _loc3_ = LanguageMgr.GetTranslation("PetFormationItemView.posFull");
            MessageTipManager.instance().show(_loc3_);
            return;
         }
         dragView = new MonopolyPetFormationItemView();
         dragView.data = data;
         dragView.isDrag = true;
         dragView.mouseChildren = dragView.mouseEnabled = false;
         var _loc6_:GameDrag = DragManager.getInstance().starDrag(this,{
            "icon":dragView,
            "type":param1
         });
         _loc6_.data = data;
         _loc6_.onDrop = dragBack;
         _loc6_.dropChecks = [MonopolyPetFormationItemView,Stage];
         this.enable = false;
         NotificationManager.instance.sendNotification("START_DRAG",dragView);
      }
      
      private function dragBack(param1:GameDrag) : void
      {
         var _loc2_:MonopolyPetFormationItemView = null;
         if(param1.dropTarget != param1.dragIcon && param1.dropTarget is MonopolyPetFormationItemView)
         {
            _loc2_ = param1.dropTarget as MonopolyPetFormationItemView;
         }
         if(param1.dragIcon)
         {
            ObjectUtils.disposeObject(param1.dragIcon);
         }
         dragView = null;
         if(_loc2_ && _loc2_.dropEnable)
         {
            if(_loc2_.data && _loc2_.data.petId == 0)
            {
               this.enable = true;
            }
            else
            {
               _loc2_.data = param1.data as PetData;
            }
         }
         else
         {
            this.enable = true;
         }
         NotificationManager.instance.sendNotification("END_DRAG",this);
      }
      
      public function get data() : PetData
      {
         return _data;
      }
      
      public function set data(param1:PetData) : void
      {
         _data = param1;
         removeEvent();
         _stateFlag.visible = false;
         if(_data)
         {
            addEvent();
            _nameTxt.text = _data.name;
            _nameTxt.setFrame(_data.quality);
            _gradeTxt.text = LanguageMgr.GetTranslation("public.level2",_data.grade);
            _icon.icon = IconFactory.getPetHeadBigIcon(_data.templateId);
            _stateFlag.visible = true;
            if(_data.isEnterWar)
            {
               _stateFlag.setFrame(2);
            }
         }
         this.tipData = _data;
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
            setFilters();
         }
         else
         {
            setFilters([UIFilter.getGrayFilter()]);
         }
      }
      
      private function setFilters(param1:Array = null) : void
      {
         _border.filters = param1;
         _back.filters = param1;
         _icon.filters = param1;
         _nameTxt.filters = param1;
         _gradeTxt.filters = param1;
      }
      
      public function get viewRectangle() : Rectangle
      {
         if(!_rect)
         {
            _rect = new Rectangle(0,0,154,63);
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

