package avenger.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.avenger.AvengerSkillInfo;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseIconView;
   
   public class AvengerSkillItem extends Component
   {
      
      private var _nameText:FilterFrameText;
      
      private var _onText:FilterFrameText;
      
      private var _skillIcon:BaseIconView;
      
      private var _skillBg:ScaleFrameImage;
      
      private var _onImage:Image;
      
      private var _selectedImage:ScaleFrameImage;
      
      private var _iconSprite:Sprite;
      
      private var _data:AvengerSkillInfo;
      
      private var _selected:Boolean;
      
      private var index:int;
      
      private var type:int;
      
      private var _isSelf:Boolean;
      
      public function AvengerSkillItem(param1:int, param2:int, param3:Boolean = true)
      {
         super();
         type = param1;
         index = param2;
         _isSelf = param3;
         initView();
         if(_isSelf)
         {
            addEvent();
         }
      }
      
      private function initView() : void
      {
         _nameText = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerSkillItem.nameText");
         _onText = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerSkillItem.onText");
         _skillIcon = ComponentFactory.Instance.creatCustomObject("Avenger.AvengerSkillItem.skillIcon");
         _skillBg = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerSkillItem.skillBg");
         _onImage = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerSkillItem.onImage");
         _selectedImage = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerSkillItem.selectedImage");
         addChild(_skillBg);
         addChild(_skillIcon);
         addChild(_selectedImage);
         addChild(_onImage);
         addChild(_onText);
         addChild(_nameText);
         _skillBg.setFrame(type);
         _selectedImage.setFrame(type);
         _selectedImage.visible = false;
         if(type == 2)
         {
            _skillIcon.mask = createSprite();
         }
      }
      
      private function createSprite() : Sprite
      {
         _iconSprite = new Sprite();
         _iconSprite.graphics.beginFill(16777215,1);
         _iconSprite.graphics.drawCircle(35,35,27);
         _iconSprite.graphics.endFill();
         addChild(_iconSprite);
         _iconSprite.mouseChildren = _iconSprite.mouseEnabled = false;
         return _iconSprite;
      }
      
      private function addEvent() : void
      {
         this.addEventListener("click",__onSelectHandler);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("click",__onSelectHandler);
      }
      
      private function __onSelectHandler(param1:MouseEvent) : void
      {
         if(selected || !data)
         {
            return;
         }
         selected = true;
         MsgMan.notifyObserver("SKILL_ITEM_SELECT",index);
      }
      
      public function get data() : AvengerSkillInfo
      {
         return _data;
      }
      
      public function set data(param1:AvengerSkillInfo) : void
      {
         _data = param1;
         if(!data || !data.skillTemp)
         {
            return;
         }
         _nameText.text = data.skillTemp.TemplateName;
         _skillIcon.icon = IconFactory.getTecIconByIcon(data.skillTemp.Icons);
         if(!_isSelf)
         {
            _skillIcon.tipData = data.skillTemp;
         }
         if(data.isFight)
         {
            _onImage.visible = true;
            _onText.text = LanguageMgr.GetTranslation("AvengerSkillItem.onText.text");
         }
         else
         {
            _onImage.visible = false;
            _onText.text = "";
         }
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         _selectedImage.visible = _selected;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_onText);
         _onText = null;
         ObjectUtils.disposeObject(_skillIcon);
         _skillIcon = null;
         ObjectUtils.disposeObject(_skillBg);
         _skillBg = null;
         ObjectUtils.disposeObject(_iconSprite);
         _iconSprite = null;
         ObjectUtils.disposeObject(_onImage);
         _onImage = null;
         ObjectUtils.disposeObject(_selectedImage);
         _selectedImage = null;
         super.dispose();
      }
   }
}

