package ancientartifact.view.item
{
   import ancientartifact.mediator.AncientBagCellClickMediator;
   import ancientartifact.mediator.AncientBagCellDropMediator;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.geom.Rectangle;
   import mvc.module.ancientartifact.AncientArmoryInfo;
   import yishi.datas.templates.ArmoryTemplateInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.MediatorMananger;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class AncientBagCell extends Component implements IManualSize
   {
      
      public static const NAME:String = "ancientartifact.view.item.AncientBagCell";
      
      private var _back:ScaleBitmapImage;
      
      private var _iconItem:BaseIconView;
      
      private var _profileBG:ScaleFrameImage;
      
      private var _data:AncientArmoryInfo;
      
      private var _strengthen:MovieImage;
      
      private var _filter:UIFilter;
      
      protected var _mediatorKey:String;
      
      public function AncientBagCell()
      {
         super();
         initView();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,45,45);
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("core.ItemBack");
         _iconItem = ComponentFactory.Instance.creatCustomObject("ancientArmoryView.StoreBagCellIcon");
         _profileBG = ComponentFactory.Instance.creatComponentByStylename("store.ProfileBG");
         _strengthen = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.Strengthen");
         addChild(_back);
         addChild(_iconItem);
         addChild(_profileBG);
         addChild(_strengthen);
         _strengthen.mouseChildren = _strengthen.mouseEnabled = _profileBG.mouseChildren = _profileBG.mouseEnabled = false;
         _strengthen.visible = false;
         _filter = new UIFilter();
         registerMediator();
      }
      
      private function registerMediator() : void
      {
         var _loc1_:Array = [AncientBagCellClickMediator,AncientBagCellDropMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"ancientartifact.view.item.AncientBagCell");
      }
      
      public function setNormalFilter() : void
      {
         _filter.setNormalFilter(this);
      }
      
      public function setGrayFilter() : void
      {
         _filter.setGrayFilter(this);
      }
      
      public function set data(param1:AncientArmoryInfo) : void
      {
         _data = param1;
         _iconItem.icon = null;
         this.tipData = null;
         _profileBG.visible = false;
         _strengthen.visible = false;
         if(!param1)
         {
            return;
         }
         this.tipData = param1;
         var _loc3_:ArmoryTemplateInfo = TempleteManager.instance.armoryTempCate.getTempInfoByTemplateId(param1.templateId,_data.profile);
         _iconItem.icon = IconFactory.getArmoryIconPath(_loc3_.TemplateId,_loc3_.Profile);
         _profileBG.visible = true;
         _profileBG.setFrame(_loc3_.Profile);
         var _loc2_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByTypeAndLevelAndID(param1.grades + 1,138,param1.profile);
         if(!_loc2_)
         {
            _strengthen.visible = true;
         }
      }
      
      override public function dispose() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_iconItem);
         _iconItem = null;
         ObjectUtils.disposeObject(_profileBG);
         _profileBG = null;
         ObjectUtils.disposeObject(_filter);
         _filter = null;
         ObjectUtils.disposeObject(_strengthen);
         _strengthen = null;
         super.dispose();
      }
      
      public function get iconItem() : BaseIconView
      {
         return _iconItem;
      }
      
      public function get data() : AncientArmoryInfo
      {
         return _data;
      }
   }
}

