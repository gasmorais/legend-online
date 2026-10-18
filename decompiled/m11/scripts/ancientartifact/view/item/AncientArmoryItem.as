package ancientartifact.view.item
{
   import ancientartifact.mediator.ArmoryItemCellClickMediator;
   import ancientartifact.mediator.ArmoryItemCellDropMediator;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import mvc.module.ancientartifact.AncientArmoryInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.MediatorMananger;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class AncientArmoryItem extends Component
   {
      
      public static const NAME:String = "ancientartifact.view.item.AncientArmoryItem";
      
      private var _back:Bitmap;
      
      private var _iconItem:BaseIconView;
      
      private var _lvlText:FilterFrameText;
      
      private var _data:AncientArmoryInfo;
      
      private var _shape:Component;
      
      private var _filter:UIFilter;
      
      private var _strengthen:MovieImage;
      
      protected var _pos:int;
      
      protected var _type:int;
      
      protected var _mediatorKey:String;
      
      public function AncientArmoryItem(param1:int = 1, param2:int = 1)
      {
         super();
         _type = param1;
         _pos = param2;
         initView();
         initEvent();
      }
      
      protected function initView() : void
      {
         if(_type == 1)
         {
            _back = ComponentFactory.Instance.creatBitmap("asset.ancientartifact.armoryItemBack");
         }
         else if(_type == 2)
         {
            _back = ComponentFactory.Instance.creatBitmap("asset.ancientartifact.armoryOtherItemBack");
         }
         else
         {
            _back = ComponentFactory.Instance.creatBitmap("asset.ancientartifact.armoryItemBack01");
         }
         _iconItem = ComponentFactory.Instance.creatCustomObject("ancientartifact.choseArmoryItemIcon");
         _lvlText = ComponentFactory.Instance.creatComponentByStylename("AncientArmoryItem.lvlText");
         _strengthen = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.Strengthen");
         addChild(_back);
         addChild(_iconItem);
         addChild(_lvlText);
         _shape = new Component();
         _shape.graphics.beginFill(16711680,0);
         _shape.graphics.drawCircle(0,0,26);
         _shape.graphics.endFill();
         addChild(_shape);
         _shape.x = 35;
         _shape.y = 42;
         addChild(_strengthen);
         _strengthen.mouseChildren = _strengthen.mouseEnabled = false;
         _strengthen.visible = false;
         _strengthen.x = 40;
         _strengthen.y = 45;
         _filter = new UIFilter();
         registerMediator();
         if(_type == 2)
         {
            _shape.x = 35;
            _shape.y = 35;
            _iconItem.y = 4;
         }
      }
      
      private function registerMediator() : void
      {
         var _loc1_:Array = [ArmoryItemCellClickMediator,ArmoryItemCellDropMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"ancientartifact.view.item.AncientArmoryItem");
      }
      
      private function initEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
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
            _strengthen.visible = false;
            _lvlText.text = "";
            return;
         }
         this.tipData = param1;
         _lvlText.text = LanguageMgr.GetTranslation("public.level2",_data.grades);
         _iconItem.icon = IconFactory.getArmoryIconPath(_data.templateId,_data.profile);
         var _loc2_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByTypeAndLevelAndID(_data.grades + 1,138,_data.profile);
         if(!_loc2_)
         {
            _strengthen.visible = true;
         }
         if(_type != 3)
         {
            _iconItem.mask = _shape;
         }
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
         ObjectUtils.disposeObject(_shape);
         _shape = null;
         ObjectUtils.disposeObject(_filter);
         _filter = null;
         ObjectUtils.disposeObject(_strengthen);
         _strengthen = null;
         ObjectUtils.disposeObject(_lvlText);
         _lvlText = null;
         super.dispose();
      }
      
      public function get iconItem() : BaseIconView
      {
         return _iconItem;
      }
   }
}

