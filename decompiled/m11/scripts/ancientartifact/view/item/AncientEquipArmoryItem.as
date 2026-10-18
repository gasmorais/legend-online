package ancientartifact.view.item
{
   import ancientartifact.mediator.ArmoryEquipItemCellClickMediator;
   import ancientartifact.mediator.ArmoryEquipItemCellDropMediator;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import mvc.module.ancientartifact.AncientArmoryInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.MediatorMananger;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class AncientEquipArmoryItem extends Component
   {
      
      public static const NAME:String = "ancientartifact.view.item.AncientEquipArmoryItem";
      
      private var _back:Bitmap;
      
      private var _lockBack:Bitmap;
      
      private var _iconItem:BaseIconView;
      
      private var _data:AncientArmoryInfo;
      
      private var _filter:UIFilter;
      
      private var _profileBG:ScaleFrameImage;
      
      private var _strengthen:MovieImage;
      
      private var _pos:int;
      
      private var _isLock:Boolean;
      
      protected var _mediatorKey:String;
      
      public function AncientEquipArmoryItem(param1:int = 1)
      {
         super();
         _pos = param1;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.ancientartifact.armoryItemBack01");
         _lockBack = ComponentFactory.Instance.creatBitmap("asset.ancientartifact.armoryItemLock");
         _iconItem = ComponentFactory.Instance.creatCustomObject("ancientartifact.equipArmoryItemIcon");
         _profileBG = ComponentFactory.Instance.creatComponentByStylename("store.ProfileBG");
         _strengthen = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.Strengthen");
         addChild(_back);
         addChild(_lockBack);
         addChild(_iconItem);
         addChild(_profileBG);
         addChild(_strengthen);
         _strengthen.mouseChildren = _strengthen.mouseEnabled = _profileBG.mouseChildren = _profileBG.mouseEnabled = false;
         _strengthen.visible = false;
         _lockBack.visible = false;
         _filter = new UIFilter();
         _profileBG.width = _profileBG.height = 48;
         registerMediator();
      }
      
      private function registerMediator() : void
      {
         var _loc1_:Array = [ArmoryEquipItemCellClickMediator,ArmoryEquipItemCellDropMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"ancientartifact.view.item.AncientEquipArmoryItem");
      }
      
      private function initEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function set isLock(param1:Boolean) : void
      {
         _isLock = param1;
         _lockBack.visible = _isLock;
      }
      
      public function get isLock() : Boolean
      {
         return _isLock;
      }
      
      public function get pos() : int
      {
         return _pos;
      }
      
      public function get data() : AncientArmoryInfo
      {
         return _data;
      }
      
      public function set data(param1:AncientArmoryInfo) : void
      {
         _data = param1;
         if(!_data)
         {
            _iconItem.icon = null;
            this.tipData = null;
            _profileBG.visible = false;
            _strengthen.visible = false;
            return;
         }
         this.tipData = param1;
         _profileBG.visible = true;
         _profileBG.setFrame(_data.profile);
         _iconItem.icon = IconFactory.getArmoryIconPath(_data.templateId,_data.profile);
         var _loc2_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByTypeAndLevelAndID(_data.grades + 1,138,_data.profile);
         _strengthen.visible = !_loc2_;
      }
      
      public function setNormalFilter() : void
      {
         _filter.setNormalFilter(this);
      }
      
      public function setGrayFilter() : void
      {
         _filter.setGrayFilter(this);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_iconItem);
         _iconItem = null;
         ObjectUtils.disposeObject(_filter);
         _filter = null;
         ObjectUtils.disposeObject(_profileBG);
         _profileBG = null;
         ObjectUtils.disposeObject(_lockBack);
         _lockBack = null;
         ObjectUtils.disposeObject(_strengthen);
         _strengthen = null;
         super.dispose();
      }
      
      public function get iconItem() : BaseIconView
      {
         return _iconItem;
      }
   }
}

