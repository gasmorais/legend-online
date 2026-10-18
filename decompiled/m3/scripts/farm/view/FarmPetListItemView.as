package farm.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import mvc.module.pet.PetData;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.filter.UIFilter;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BaseItemView;
   
   public class FarmPetListItemView extends Component implements ISelectable
   {
      
      private var _headBorder:ScaleBitmapImage;
      
      protected var _headIcon:BaseIconView;
      
      private var _bg:ScaleBitmapImage;
      
      protected var _nameTxt:FilterFrameText;
      
      protected var _lvTxt:FilterFrameText;
      
      private var _gradeTxt:FilterFrameText;
      
      protected var _overbg:Scale9CornerImage;
      
      private var _uiFilter:UIFilter;
      
      private var _line:ScaleBitmapImage;
      
      private var _cell:BaseItemView;
      
      protected var _hBox:HBox;
      
      private var _data:PetData;
      
      private var _selected:Boolean;
      
      private var _enable:Boolean = true;
      
      public function FarmPetListItemView()
      {
         super();
         _uiFilter = new UIFilter();
      }
      
      override protected function init() : void
      {
         _headBorder = ComponentFactory.Instance.creatComponentByStylename("FarmPetListItemView.HeadBorder");
         _headIcon = ComponentFactory.Instance.creatCustomObject("FarmPetListItemView.HeadIcon");
         _bg = ComponentFactory.Instance.creatComponentByStylename("FarmPetListItemView.Back");
         _line = ComponentFactory.Instance.creatComponentByStylename("FarmPetListItemView.Line");
         _overbg = ComponentFactory.Instance.creatComponentByStylename("FarmPetListItemView.MouseOver");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("farm.PetNameTxt");
         _lvTxt = ComponentFactory.Instance.creatComponentByStylename("farm.PetLvTxt");
         _gradeTxt = ComponentFactory.Instance.creatComponentByStylename("farm.PetGradeTxt");
         _hBox = new HBox();
         _hBox.spacing = 1;
         addChild(_bg);
         addChild(_line);
         addChild(_headBorder);
         addChild(_headIcon);
         addChild(_overbg);
         addChild(_nameTxt);
         addChild(_lvTxt);
         addChild(_gradeTxt);
         addChild(_hBox);
         _hBox.x = 100;
         _hBox.y = 33;
         _overbg.visible = false;
         _lvTxt.text = LanguageMgr.GetTranslation("public.level3");
      }
      
      public function get data() : PetData
      {
         return _data;
      }
      
      public function set data(param1:PetData) : void
      {
         _data = param1;
         if(_hBox)
         {
            _hBox.removeAllChild();
         }
         if(_data)
         {
            this.mouseEnabled = true;
            _headIcon.icon = IconFactory.getPetHeadSmallIcon(data.templateId);
            _nameTxt.text = _data.name;
            _nameTxt.setFrame(_data.quality);
            _gradeTxt.text = data.grade.toString();
            _lvTxt.visible = true;
            showStar(_data.temQuality);
         }
         else
         {
            this.mouseEnabled = false;
            _headIcon.icon = null;
            _nameTxt.text = "";
            _gradeTxt.text = "";
            _lvTxt.visible = false;
         }
      }
      
      private function showStar(param1:int) : void
      {
         var _loc4_:String = null;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:Bitmap = null;
         var _loc2_:UpgradeTemplateInfo = _data.qualityUpgradeTemplateInfo;
         if(_loc2_ == null)
         {
            return;
         }
         _loc3_ = _data.temQuality % 5 == 0 ? 5 : _data.temQuality % 5;
         if(_data.temQuality > 25)
         {
            _loc4_ = "asset.pet.bigMoonLightLevelImg";
         }
         else
         {
            _loc4_ = "asset.pet.StarLevelLightImg";
         }
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc5_ = ComponentFactory.Instance.creatBitmap(_loc4_);
            _hBox.addChild(_loc5_);
            _loc6_++;
         }
      }
      
      public function setType(param1:int = 0) : void
      {
         if(param1 == 1)
         {
            _cell = ComponentFactory.Instance.creatCustomObject("acution.BagCell");
            _headIcon.visible = false;
            addChild(_cell);
            _cell.data = _data.convertToGoods();
            _cell.bagType = _data.convertToGoods().bagType;
            _cell.pos = _data.convertToGoods().pos;
            _cell.x = _cell.y = 6;
         }
      }
      
      public function get cell() : BaseItemView
      {
         return _cell;
      }
      
      public function mouseOver() : void
      {
         if(!data)
         {
            return;
         }
         if(!enable)
         {
            return;
         }
         if(selected)
         {
            return;
         }
         if(_overbg)
         {
            _overbg.visible = true;
         }
      }
      
      public function mouseOut() : void
      {
         if(!data)
         {
            return;
         }
         if(!enable)
         {
            return;
         }
         if(selected)
         {
            return;
         }
         if(_overbg)
         {
            _overbg.visible = false;
         }
      }
      
      override public function dispose() : void
      {
         _uiFilter = null;
         _nameTxt = null;
         _lvTxt = null;
         _gradeTxt = null;
         _overbg = null;
         _cell = null;
         _hBox = null;
         super.dispose();
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         if(_overbg)
         {
            _overbg.visible = _selected;
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
         mouseEnabled = _enable;
         buttonMode = _enable;
         if(_enable)
         {
            _uiFilter.setNormalFilter(this);
         }
         else
         {
            _uiFilter.setGrayFilter(this);
         }
      }
   }
}

