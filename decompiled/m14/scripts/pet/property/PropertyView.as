package pet.property
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconTextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.pet.PetData;
   import pet.advanced.PetEquipBagView;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   
   public class PropertyView extends Component
   {
      
      private var _showView:PetShowView;
      
      private var _morphSkillView:MorphingSkillView;
      
      private var _growthView:GrowthInfoView;
      
      private var _detailView:DetailInfoView;
      
      private var _petBagView:PetEquipBagView;
      
      private var _normalSkillView:NormalSkillView;
      
      private var _growthBtn:SelectedIconTextButton;
      
      private var _detailInfoBtn:SelectedIconTextButton;
      
      private var _equipBtn:SelectedIconTextButton;
      
      private var _group:SelectedButtonGroup;
      
      private var _lineTop:ScaleBitmapImage;
      
      private var _data:PetData;
      
      public function PropertyView()
      {
         super();
         initView();
         addEvent();
         this.mouseEnabled = false;
      }
      
      private function initView() : void
      {
         _showView = new PetShowView();
         _showView.state = 0;
         _morphSkillView = new MorphingSkillView();
         _growthView = new GrowthInfoView();
         _detailView = new DetailInfoView();
         _petBagView = new PetEquipBagView(8,6);
         _normalSkillView = new NormalSkillView();
         _group = new SelectedButtonGroup();
         _growthBtn = ComponentFactory.Instance.creatComponentByStylename("pet.GrowthSelectedTextButton");
         _detailInfoBtn = ComponentFactory.Instance.creatComponentByStylename("pet.DetailSelectedTextButton");
         _equipBtn = ComponentFactory.Instance.creatComponentByStylename("pet.equipBagSelectedTextButton");
         _group.addSelectItem(_growthBtn);
         _group.addSelectItem(_detailInfoBtn);
         _group.addSelectItem(_equipBtn);
         _group.selectIndex = 0;
         _showView.x = -2;
         _showView.y = 5;
         _morphSkillView.x = -4;
         _morphSkillView.y = 279;
         _normalSkillView.x = 375;
         _normalSkillView.y = 346;
         _growthView.x = 329;
         _growthView.y = 20;
         _detailView.x = 337;
         _detailView.y = 18;
         _petBagView.x = 312;
         _petBagView.y = 27;
         addChild(_growthBtn);
         addChild(_detailInfoBtn);
         addChild(_equipBtn);
         _lineTop = ComponentFactory.Instance.creatComponentByStylename("pet.HLineA");
         _lineTop.width = 305;
         _lineTop.x = 305;
         _lineTop.y = 23;
         addChild(_lineTop);
         addChild(_petBagView);
         addChild(_showView);
         addChild(_morphSkillView);
         addChild(_normalSkillView);
         addChild(_growthView);
         addChild(_detailView);
         _detailView.visible = false;
         _petBagView.visible = false;
         _growthBtn.text = LanguageMgr.GetTranslation("pet.PetFrame.growthRes");
         _detailInfoBtn.text = LanguageMgr.GetTranslation("pet.PetFrame.detailProperty");
         _equipBtn.text = LanguageMgr.GetTranslation("pet.PetFrame.equipBag");
      }
      
      private function __showBagHandler(param1:NotificationEvent) : void
      {
         _equipBtn.dispatchEvent(new MouseEvent("click"));
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_showView);
         _showView = null;
         ObjectUtils.disposeObject(_morphSkillView);
         _morphSkillView = null;
         ObjectUtils.disposeObject(_growthView);
         _growthView = null;
         ObjectUtils.disposeObject(_detailView);
         _detailView = null;
         ObjectUtils.disposeObject(_petBagView);
         _petBagView = null;
         ObjectUtils.disposeObject(_equipBtn);
         _equipBtn = null;
         ObjectUtils.disposeObject(_normalSkillView);
         _normalSkillView = null;
         ObjectUtils.disposeObject(_growthBtn);
         _growthBtn = null;
         ObjectUtils.disposeObject(_detailInfoBtn);
         _detailInfoBtn = null;
         ObjectUtils.disposeObject(_group);
         _group = null;
         ObjectUtils.disposeObject(_lineTop);
         _lineTop = null;
      }
      
      private function addEvent() : void
      {
         _group.addEventListener("change",__selectChangedHandler);
         NotificationManager.instance.addEventListener("SHOWPETBAG",__showBagHandler);
      }
      
      private function removeEvent() : void
      {
         if(_group)
         {
            _group.removeEventListener("change",__selectChangedHandler);
         }
         NotificationManager.instance.removeEventListener("SHOWPETBAG",__showBagHandler);
      }
      
      private function __selectChangedHandler(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(_group)
         {
            _loc2_ = int(_group.selectIndex);
         }
         if(_loc2_ == 0)
         {
            _growthView.visible = true;
            _detailView.visible = false;
            _petBagView.visible = false;
            _normalSkillView.visible = true;
            _normalSkillView.y = 346;
         }
         else if(_loc2_ == 1)
         {
            _growthView.visible = false;
            _detailView.visible = true;
            _petBagView.visible = false;
            _normalSkillView.visible = true;
            _normalSkillView.y = 366;
         }
         else if(_loc2_ == 2)
         {
            NotificationManager.instance.dispatchEvent(new NotificationEvent("PETSTORECHANGEPAGE"));
            _growthView.visible = false;
            _detailView.visible = false;
            _petBagView.visible = true;
            _normalSkillView.visible = false;
         }
      }
      
      public function get data() : PetData
      {
         return _data;
      }
      
      public function set data(param1:PetData) : void
      {
         _data = param1;
         _showView.data = param1;
         _morphSkillView.data = param1;
         _normalSkillView.data = param1;
         _growthView.data = param1;
         _detailView.data = param1;
      }
      
      public function get petShowView() : PetShowView
      {
         return _showView;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uintView();
         super.dispose();
         _data = null;
      }
   }
}

