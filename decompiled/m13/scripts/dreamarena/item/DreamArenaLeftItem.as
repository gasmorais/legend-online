package dreamarena.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import dreamarena.helper.DreamArenaViewHelper;
   import flash.events.MouseEvent;
   import managers.DreamArenaManager;
   import mvc.module.dreamarena.DreamArenaModel;
   import mvc.module.dreamarena.DreamArenaSelectRoleInfo;
   import yishi.datas.templates.DreamArenaTempInfo;
   import yishi.datas.templates.PetTemplate;
   import yishi.datas.templates.RuneTemplateInfo;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class DreamArenaLeftItem extends Component
   {
      
      private var _descText:FilterFrameText;
      
      private var _headBack:Image;
      
      private var _headIcon:BaseIconView;
      
      private var _headBackII:Image;
      
      private var _headIconII:BaseIconView;
      
      private var _nameBack:Image;
      
      private var _itemBack:Image;
      
      private var _selectBg:Image;
      
      private var _nameImage:ScaleFrameImage;
      
      private var _index:int;
      
      private var _selected:Boolean = false;
      
      public function DreamArenaLeftItem(param1:int)
      {
         super();
         _index = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _descText = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaLeftItem.descText");
         _headIcon = ComponentFactory.Instance.creatCustomObject("DreamArena.DreamArenaLeftItem.headIcon");
         _headIconII = ComponentFactory.Instance.creatCustomObject("DreamArena.DreamArenaLeftItem.petIcon");
         _nameBack = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaLeftItem.nameBack");
         _itemBack = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaLeftItem.itemBack");
         _selectBg = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaLeftItem.selectBg");
         _nameImage = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaLeftItem.nameImage");
         _headBack = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaLeftItem.headBack");
         _headBackII = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaLeftItem.headBackII");
         addChild(_itemBack);
         addChild(_nameBack);
         addChild(_headBack);
         addChild(_headIcon);
         addChild(_headBackII);
         addChild(_headIconII);
         addChild(_nameImage);
         addChild(_descText);
         addChild(_selectBg);
         _nameImage.setFrame(1);
         this.buttonMode = true;
         _selectBg.visible = false;
         _selectBg.mouseEnabled = false;
         _nameImage.mouseEnabled = false;
      }
      
      private function get isShowHeadII() : Boolean
      {
         if(index == 7 || index == 8 || index == 2)
         {
            return true;
         }
         return false;
      }
      
      private function addEvent() : void
      {
         addEventListener("click",__itemSelectHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__itemSelectHandler);
      }
      
      private function __itemSelectHandler(param1:MouseEvent) : void
      {
         model.selectIndex = index;
      }
      
      public function refreshView() : void
      {
         var _loc4_:PetTemplate = null;
         var _loc2_:RuneTemplateInfo = null;
         var _loc3_:DreamArenaTempInfo = null;
         _selectBg.visible = model.selectIndex == index;
         var _loc1_:Object = DreamArenaViewHelper.getLeftItemData(index,selectInfo);
         if(!_loc1_)
         {
            return;
         }
         refreshVisbleAndPos();
         _nameImage.setFrame(_loc1_.frame);
         _descText.text = _loc1_.content;
         _headIcon.icon = _loc1_.icon;
         _headIcon.tipStyle = _loc1_.tipStyle;
         _headIcon.tipData = _loc1_.tipData;
         if(index == 2)
         {
            _loc2_ = selectInfo.getRuneTempInfoById(selectInfo.runeId2);
            _headIconII.tipStyle = "yishi.view.tips.goods.RuneTips";
            _headIconII.icon = IconFactory.getTecIconByIcon(_loc2_.Icon);
            _headIconII.tipData = _loc2_;
         }
         else if(index == 7)
         {
            _loc4_ = selectInfo.getPetTempInfoById(selectInfo.mainChildPetId);
            _loc3_ = selectInfo.getDreamArenaById(selectInfo.mainChildPetId);
            _headIconII.icon = _loc4_ ? IconFactory.getPetHeadSmallIcon(_loc4_.TemplateId) : null;
            _headIconII.tipStyle = "yishi.view.tips.DreamArenaPetTips";
            _headIconII.tipData = _loc3_;
         }
         else if(index == 8)
         {
            _loc4_ = selectInfo.getPetTempInfoById(selectInfo.slaveChildPetId);
            _loc3_ = selectInfo.getDreamArenaById(selectInfo.slaveChildPetId);
            _headIconII.icon = _loc4_ ? IconFactory.getPetHeadSmallIcon(_loc4_.TemplateId) : null;
            _headIconII.tipStyle = "yishi.view.tips.DreamArenaPetTips";
            _headIconII.tipData = _loc3_;
         }
      }
      
      private function refreshVisbleAndPos() : void
      {
         if(isShowHeadII)
         {
            _headBackII.visible = _headIconII.visible = true;
            _nameBack.x = 100;
            _nameBack.y = 25;
            _nameImage.x = 140;
            _nameImage.y = 25;
         }
         else
         {
            _headBackII.visible = _headIconII.visible = false;
            _nameBack.x = 27;
            _nameBack.y = 16;
            _nameImage.x = 69;
            _nameImage.y = 18;
         }
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      private function get selectInfo() : DreamArenaSelectRoleInfo
      {
         return model.selfInfo;
      }
      
      private function get model() : DreamArenaModel
      {
         return DreamArenaManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_descText);
         _descText = null;
         ObjectUtils.disposeObject(_headIcon);
         _headIcon = null;
         ObjectUtils.disposeObject(_headIconII);
         _headIconII = null;
         ObjectUtils.disposeObject(_nameBack);
         _nameBack = null;
         ObjectUtils.disposeObject(_itemBack);
         _itemBack = null;
         ObjectUtils.disposeObject(_selectBg);
         _selectBg = null;
         ObjectUtils.disposeObject(_nameImage);
         _nameImage = null;
         ObjectUtils.disposeObject(_headBack);
         _headBack = null;
         ObjectUtils.disposeObject(_headBackII);
         _headBackII = null;
         super.dispose();
      }
   }
}

