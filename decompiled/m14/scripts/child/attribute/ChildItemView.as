package child.attribute
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildData;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseIconView;
   
   public class ChildItemView extends Component implements ISelectable
   {
      
      protected var _bg:MutipleImage;
      
      protected var _selectedBg:Scale9CornerImage;
      
      protected var _jobImage:ScaleFrameImage;
      
      protected var _icon:BaseIconView;
      
      protected var _enterWarIcon:ScaleFrameImage;
      
      protected var _nameTxt:FilterFrameText;
      
      protected var _gradeTxt:FilterFrameText;
      
      protected var _selected:Boolean;
      
      protected var _data:ChildData;
      
      protected var _fightingCapacity:FilterFrameText;
      
      protected var _filter:UIFilter;
      
      public function ChildItemView()
      {
         super();
         initView();
         initEvent();
      }
      
      protected function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ChildItemView.bg");
         _jobImage = ComponentFactory.Instance.creatComponentByStylename("ChildItemView.jobImage");
         _enterWarIcon = ComponentFactory.Instance.creatComponentByStylename("ChildItemView.enterWarIcon");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("ChildItemView.nameTxt");
         _gradeTxt = ComponentFactory.Instance.creatComponentByStylename("ChildShowView.itemGradeTxt");
         _selectedBg = ComponentFactory.Instance.creatComponentByStylename("ChildItemView.selectedBg");
         _icon = ComponentFactory.Instance.creatCustomObject("ChildItemView.headIcon");
         _fightingCapacity = ComponentFactory.Instance.creatComponentByStylename("childarena.fightingCapacity");
         _filter = new UIFilter();
         addChild(_bg);
         addChild(_icon);
         addChild(_enterWarIcon);
         addChild(_nameTxt);
         addChild(_gradeTxt);
         addChild(_fightingCapacity);
         addChild(_selectedBg);
         buttonMode = true;
         selected = false;
         _selectedBg.mouseEnabled = _selectedBg.mouseChildren = false;
         _icon.mouseEnabled = _icon.mouseChildren = false;
      }
      
      protected function initEvent() : void
      {
         addEventListener("click",__itemClickHandler);
         MsgMan.addObserver("ChildEvent.CHILD_INFO",this,__infoHandler);
      }
      
      protected function removeEvent() : void
      {
         removeEventListener("click",__itemClickHandler);
         MsgMan.removeObserver("ChildEvent.CHILD_INFO",this,__infoHandler);
      }
      
      public function set enable(param1:Boolean) : void
      {
         buttonMode = param1;
         this.mouseEnabled = this.mouseChildren = param1;
         if(param1)
         {
            this.filters = [];
         }
         else
         {
            _filter.setGrayFilter(this);
         }
      }
      
      protected function __infoHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      public function get data() : ChildData
      {
         return _data;
      }
      
      public function set data(param1:ChildData) : void
      {
         restore();
         _data = param1;
         refreshView();
      }
      
      protected function restore() : void
      {
         _nameTxt.text = "";
         _gradeTxt.text = "";
         _fightingCapacity.text = "";
         _nameTxt.visible = false;
         _gradeTxt.visible = false;
         _bg.visible = false;
         _fightingCapacity.visible = false;
         _icon.visible = false;
         _jobImage.visible = false;
         _enterWarIcon.visible = false;
         _selectedBg.visible = false;
         selected = false;
      }
      
      protected function refreshView() : void
      {
         var _loc1_:ChildTempInfo = null;
         var _loc2_:String = null;
         if(_data)
         {
            _nameTxt.visible = true;
            _gradeTxt.visible = true;
            _bg.visible = true;
            _fightingCapacity.visible = true;
            _jobImage.visible = true;
            _jobImage.setFrame(_data.job);
            _enterWarIcon.visible = true;
            setEnterWarIcon();
            _loc1_ = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_data.job,_data.growthGrade);
            _loc2_ = _loc1_.JobName;
            _nameTxt.text = _loc2_;
            _fightingCapacity.text = LanguageMgr.GetTranslation("childarena.childFightingCapacity",_data.fightValue);
            _gradeTxt.text = _gradeTxt.text = LanguageMgr.GetTranslation("public.level2",_data.growthGrade);
            _icon.icon = PathManager.info.ResourcePath + "icon" + _loc1_.Icon;
            _icon.visible = true;
         }
      }
      
      protected function __itemClickHandler(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
         ChildManager.instance.model.selectedChild = data;
      }
      
      protected function setDescribeTxt() : void
      {
      }
      
      private function setEnterWarIcon() : void
      {
         if(_data.fightUserId > 0)
         {
            _enterWarIcon.visible = true;
            if(_data.fightUserId == playerInfo.userId)
            {
               _enterWarIcon.setFrame(1);
            }
            else
            {
               _enterWarIcon.setFrame(2);
            }
         }
         else
         {
            _enterWarIcon.visible = false;
         }
      }
      
      private function setHeadIcon() : void
      {
      }
      
      protected function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      protected function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         if(_selectedBg)
         {
            _selectedBg.visible = _selected;
         }
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      override public function dispose() : void
      {
         removeEvent();
         this.filters = [];
         _filter = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_jobImage);
         _jobImage = null;
         ObjectUtils.disposeObject(_enterWarIcon);
         _enterWarIcon = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_gradeTxt);
         _gradeTxt = null;
         ObjectUtils.disposeObject(_fightingCapacity);
         _fightingCapacity = null;
         ObjectUtils.disposeObject(_selectedBg);
         _selectedBg = null;
         _data = null;
         super.dispose();
      }
   }
}

