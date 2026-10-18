package ancientartifact.view.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.ancientartifact.AncientArtifactInfo;
   import mvc.module.ancientartifact.AncientArtifactModel;
   import yishi.datas.templates.ArtifactTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.filter.UIFilter;
   import yishi.manager.AncientArtifactManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class AncientArtifactItem extends Component
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _overbg:ScaleFrameImage;
      
      private var _icon:BaseIconView;
      
      private var _nameTxt:FilterFrameText;
      
      private var _lvlText:FilterFrameText;
      
      private var _data:AncientArtifactInfo;
      
      private var _template:ArtifactTemplateInfo;
      
      private var _selected:Boolean;
      
      private var _stars:AncientStarsItem;
      
      private var _itemEquip1:Bitmap;
      
      private var _itemEquip2:Bitmap;
      
      private var _filter:UIFilter;
      
      public function AncientArtifactItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("AncientArtifactItem.PetItemBg");
         _overbg = ComponentFactory.Instance.creatComponentByStylename("AncientArtifactItem.PetItemMouseOver");
         _icon = ComponentFactory.Instance.creatCustomObject("ancientartifact.BaseItemViewIcon2");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("AncientArtifactItem.itemName");
         _lvlText = ComponentFactory.Instance.creatComponentByStylename("AncientArtifactItem.lvlText");
         _itemEquip1 = ComponentFactory.Instance.creatBitmap("asset.ancientartifact.itemEquip1");
         _itemEquip2 = ComponentFactory.Instance.creatBitmap("asset.ancientartifact.itemEquip2");
         addChild(_bg);
         addChild(_overbg);
         addChild(_icon);
         addChild(_lvlText);
         addChild(_nameTxt);
         addChild(_itemEquip1);
         addChild(_itemEquip2);
         _filter = new UIFilter();
      }
      
      private function addEvent() : void
      {
         this.addEventListener("mouseOver",__mouseOverHandler);
         this.addEventListener("mouseOut",__mouseOutHandler);
         this.addEventListener("click",__mouseClickHandler);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("mouseOver",__mouseOverHandler);
         this.removeEventListener("mouseOut",__mouseOutHandler);
         this.removeEventListener("click",__mouseClickHandler);
      }
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
         if(selected)
         {
            return;
         }
         _overbg.visible = true;
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         if(selected)
         {
            return;
         }
         _overbg.visible = false;
      }
      
      private function __mouseClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         AncientArtifactManager.instance.selectTempId = _template.TemplateId;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("ARTIFACT_ITEM_CLICK"));
      }
      
      public function get data() : AncientArtifactInfo
      {
         return _data;
      }
      
      public function get info() : ArtifactTemplateInfo
      {
         return _template;
      }
      
      public function set info(param1:ArtifactTemplateInfo) : void
      {
         _template = param1;
         _data = model.getArtifactInfoById(_template.TemplateId);
         clearData();
         _icon.icon = IconFactory.getCommonIconPath(_template.Icon);
         _icon.tipData = {
            "type":"current",
            "tempInfo":_template
         };
         _nameTxt.text = _template.TemplateName;
         if(_data)
         {
            _stars = new AncientStarsItem(_template,_data);
            _stars.x = 84;
            _stars.y = 53;
            addChild(_stars);
            _itemEquip1.visible = _itemEquip2.visible = _data.isEquip;
            _lvlText.text = LanguageMgr.GetTranslation("public.level2",_data.level);
            _filter.setNormalFilter(this);
         }
         else
         {
            _lvlText.text = "";
            _filter.setGrayFilter(this);
         }
      }
      
      private function clearData() : void
      {
         _itemEquip1.visible = false;
         _itemEquip2.visible = false;
         ObjectUtils.disposeObject(_stars);
         _stars = null;
      }
      
      private function get isMyInfo() : Boolean
      {
         if(_data.templateId == AncientArtifactManager.instance.selectTempId)
         {
            return true;
         }
         return false;
      }
      
      private function get model() : AncientArtifactModel
      {
         return AncientArtifactManager.instance.model;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         _overbg.visible = _selected;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_overbg);
         _overbg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_lvlText);
         _lvlText = null;
         ObjectUtils.disposeObject(_stars);
         _stars = null;
         ObjectUtils.disposeObject(_itemEquip1);
         _itemEquip1 = null;
         ObjectUtils.disposeObject(_itemEquip2);
         _itemEquip2 = null;
         _filter = null;
         _data = null;
         _template = null;
         super.dispose();
      }
   }
}

