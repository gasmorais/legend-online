package consortia.view.crossguild.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import mvc.module.crossguild.CrossGuildModel;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.CrossGuildManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class CrossGuildBufferSelectItem extends Component
   {
      
      private var _indexText:FilterFrameText;
      
      private var _profileImage:ScaleFrameImage;
      
      private var _skillIcon:BaseIconView;
      
      private var _skillDescText:FilterFrameText;
      
      private var _selectBtn:IconButton;
      
      private var _data:SkillTempInfo;
      
      private var index:int;
      
      private var page:int;
      
      private var pageCount:int = 5;
      
      public function CrossGuildBufferSelectItem(param1:int)
      {
         super();
         index = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _indexText = ComponentFactory.Instance.creatComponentByStylename("CrossGuildBufferSelectItem.indexText");
         _profileImage = ComponentFactory.Instance.creatComponentByStylename("CrossGuildBufferSelectItem.profileImage");
         _skillIcon = ComponentFactory.Instance.creatCustomObject("CrossGuildBufferSelectItem.skillIcon");
         _skillDescText = ComponentFactory.Instance.creatComponentByStylename("CrossGuildBufferSelectItem.skillDescText");
         _selectBtn = ComponentFactory.Instance.creatComponentByStylename("CrossGuildBufferSelectItem.selectBtn");
         addChild(_indexText);
         addChild(_skillIcon);
         addChild(_profileImage);
         _profileImage.mouseEnabled = false;
         addChild(_skillDescText);
         addChild(_selectBtn);
         _profileImage.mouseEnabled = false;
         _profileImage.visible = false;
      }
      
      private function addEvent() : void
      {
         _selectBtn.addEventListener("click",__selectSkillHandler);
      }
      
      private function removeEvent() : void
      {
         if(_selectBtn)
         {
            _selectBtn.removeEventListener("click",__selectSkillHandler);
         }
      }
      
      private function __selectSkillHandler(param1:MouseEvent) : void
      {
         if(!data)
         {
            return;
         }
         CrossGuildManager.instance.sendBufferSelect(3,data.TemplateId);
      }
      
      public function get data() : SkillTempInfo
      {
         return _data;
      }
      
      public function set data(param1:SkillTempInfo) : void
      {
         _data = param1;
         if(data)
         {
            _skillIcon.visible = true;
            _selectBtn.visible = true;
            _skillIcon.icon = IconFactory.getTecIconByIcon(data.Icons);
            _skillIcon.tipData = data;
            _skillDescText.text = data.Description;
            _selectBtn.enable = data.TemplateId != model.selfGuildBufferId && model.state == 4 && model.signType;
            _profileImage.visible = data.Grades > 1;
            _profileImage.setFrame(data.Grades - 1);
         }
         else
         {
            _indexText.text = "";
            _skillIcon.visible = false;
            _skillDescText.text = "";
            _selectBtn.visible = false;
            _profileImage.visible = false;
         }
      }
      
      public function setPage(param1:int) : void
      {
         page = param1;
         _indexText.text = data ? index + (page - 1) * pageCount + "" : "";
      }
      
      private function get model() : CrossGuildModel
      {
         return CrossGuildManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_indexText);
         _indexText = null;
         ObjectUtils.disposeObject(_skillIcon);
         _skillIcon = null;
         ObjectUtils.disposeObject(_skillDescText);
         _skillDescText = null;
         ObjectUtils.disposeObject(_selectBtn);
         _selectBtn = null;
         ObjectUtils.disposeObject(_profileImage);
         _profileImage = null;
         super.dispose();
      }
   }
}

