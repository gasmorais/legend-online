package childpve
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   import mainBar.effects.MainToolBtnGlowEffect;
   import manager.LanguageMgr;
   import mvc.controler.ChildPveController;
   import mvc.module.armyII.SkillInfo;
   import mvc.module.children.BossInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.FrameControllerManager;
   import yishi.view.component.TileContainer;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildPveReadyFrame extends Frame
   {
      
      private var _selectIndex:int = -1;
      
      private var _buttonBg:Bitmap;
      
      private var _wantedSkill:Bitmap;
      
      private var _splitLine:Bitmap;
      
      private var _backBorder:Scale9CornerImage;
      
      private var _allBossBorder:ScaleBitmapImage;
      
      private var _childConfigBtn:IconButton;
      
      private var _sortLinkTxt:FilterFrameText;
      
      private var _sortLink:Sprite;
      
      private var _tileContainer:TileContainer;
      
      private var _itemList:Vector.<ChildPveBossItem>;
      
      private var _helpBtn:BaseButton;
      
      private var _hBox:HBox;
      
      private var _challege:Image;
      
      private var _skillList:Array;
      
      private var _controller:ChildPveController = FrameControllerManager.instance.childPveController;
      
      private var _filter:IFilterFormat;
      
      private var _sortView:ChildPveOrderFrame;
      
      private var _disEffect:MainToolBtnGlowEffect;
      
      public function ChildPveReadyFrame()
      {
         _controller.model.setfirstChild(_controller.model.firstChildId);
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _skillList = [];
         titleText = LanguageMgr.GetTranslation("childpve.title");
         _backBorder = ComponentFactory.Instance.creatComponentByStylename("childpve.BackBorder");
         _allBossBorder = ComponentFactory.Instance.creatComponentByStylename("childpve.Frameback1");
         _buttonBg = ComponentFactory.Instance.creatBitmap("asset.childpve.buttonBg");
         _wantedSkill = ComponentFactory.Instance.creatBitmap("asset.childpve.wantedSkill");
         _childConfigBtn = ComponentFactory.Instance.creatComponentByStylename("childpve.childConfig");
         _splitLine = ComponentFactory.Instance.creatBitmap("asset.childpve.splitLine");
         _sortLinkTxt = ComponentFactory.Instance.creatComponentByStylename("childpve.SortLinkTxt");
         _sortLinkTxt.htmlText = "<a href =\'event: \'><u>" + LanguageMgr.GetTranslation("childpve.SortTitls") + "</u></a>";
         _sortLinkTxt.mouseEnabled = false;
         _tileContainer = ComponentFactory.Instance.creatCustomObject("ChildPveReadyFrame.TileContainer");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("childpve.HelpBtn");
         _helpBtn.tipData = LanguageMgr.GetTranslation("public.help");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("childpve.skill.hBox");
         _challege = ComponentFactory.Instance.creatComponentByStylename("childpve.challege");
         _filter = new UIFilter();
         _sortLink = new Sprite();
         _sortLink.addChild(_sortLinkTxt);
         _sortLink.buttonMode = true;
         addToContent(_backBorder);
         addToContent(_allBossBorder);
         addToContent(_buttonBg);
         addToContent(_wantedSkill);
         addToContent(_childConfigBtn);
         addToContent(_splitLine);
         _challege.visible = false;
         initBossView();
         addToContent(_challege);
         initSkillView();
      }
      
      private function initBossView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:ChildPveBossItem = null;
         _itemList = new Vector.<ChildPveBossItem>();
         _selectIndex = 0;
         var _loc4_:Array = _controller.pveModel.bossInfo;
         var _loc1_:int = -1;
         _loc3_ = 0;
         while(_loc3_ < 8)
         {
            _loc2_ = new ChildPveBossItem();
            _loc2_.index = _loc3_;
            _loc2_.data = _loc4_[_loc3_] as BossInfo;
            _loc2_.selectIndex = _selectIndex;
            if(_loc1_ == -1 && !_loc2_.isBeat)
            {
               _loc1_ = _loc3_;
            }
            _loc2_.addEventListener("click",bossItemClickHandle);
            _tileContainer.appendItem(_loc2_);
            _itemList.push(_loc2_);
            _loc3_++;
         }
         addToContent(_tileContainer);
         if(_loc1_ != -1)
         {
            selectBoss(_itemList[_loc1_]);
         }
      }
      
      protected function bossItemClickHandle(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         var _loc2_:ChildPveBossItem = param1.currentTarget as ChildPveBossItem;
         if(_loc2_.isBeat)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("childpve.cantFightAgain"));
            return;
         }
         selectBoss(_loc2_);
      }
      
      private function cancelSelect() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            _itemList[_loc1_].selectIndex = -1;
            _loc1_++;
         }
         _selectIndex = -1;
         _challege.visible = false;
         _challege.removeEventListener("rollOver",challegeBtnOverHandle);
         _challege.removeEventListener("rollOut",challegeBtnOutHandle);
         _challege.removeEventListener("click",challegeBtnClickHandle);
      }
      
      private function selectBoss(param1:ChildPveBossItem) : void
      {
         var _loc2_:int = 0;
         _selectIndex = param1.index;
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _itemList[_loc2_].selectIndex = _selectIndex;
            _loc2_++;
         }
         _challege.visible = true;
         if(!_disEffect)
         {
            _disEffect = new MainToolBtnGlowEffect(_challege);
         }
         _disEffect.play();
         _challege.x = _selectIndex % 4 * 168 + 45;
         _challege.y = int(_selectIndex / 4) * 190 + 78;
         _challege.addEventListener("rollOver",challegeBtnOverHandle);
         _challege.addEventListener("rollOut",challegeBtnOutHandle);
         _challege.addEventListener("click",challegeBtnClickHandle);
      }
      
      protected function challegeBtnClickHandle(param1:MouseEvent) : void
      {
         if(_controller.model.getFightChildCount() == 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("managers.ChildManager.pickChildTips"));
            return;
         }
         _controller.sendFight(_selectIndex + 1);
      }
      
      protected function challegeBtnOutHandle(param1:Event) : void
      {
         if(_challege)
         {
            _filter.setNormalFilter(_challege);
         }
         Mouse.cursor = "arrow";
      }
      
      protected function challegeBtnOverHandle(param1:Event) : void
      {
         _filter.setLightingFilter(_challege);
         if(!_disEffect)
         {
            _disEffect = new MainToolBtnGlowEffect(_challege);
         }
         _disEffect.play();
         Mouse.cursor = "button";
      }
      
      private function initSkillView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:SkillInfo = null;
         var _loc4_:ChildPveSkillItemView = null;
         var _loc2_:Vector.<SkillTempInfo> = _controller.getBossAndSkillFromTemp();
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc1_ = new SkillInfo();
            _loc4_ = new ChildPveSkillItemView();
            _loc1_.templateId = _loc2_[_loc3_].TemplateId;
            if(_controller.pveModel.skillInfo.indexOf(_loc1_.templateId + "") > -1)
            {
               _loc1_.grade = 1;
            }
            _loc4_.data = _loc1_;
            _loc4_.x = _loc3_ * 52 + 92;
            _loc4_.y = 406;
            addToContent(_loc4_);
            _skillList.push(_loc4_);
            _loc3_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         addEventListener("click",__frameClick);
         _helpBtn.addEventListener("click",__helpHandler);
         _childConfigBtn.addEventListener("click",__openFormationHandler);
         _sortLink.addEventListener("click",__SortHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         removeEventListener("click",__frameClick);
         _helpBtn.removeEventListener("click",__helpHandler);
         if(_childConfigBtn)
         {
            _childConfigBtn.removeEventListener("click",__openFormationHandler);
         }
         _sortLink.removeEventListener("click",__SortHandler);
      }
      
      private function __frameClick(param1:MouseEvent) : void
      {
         cancelSelect();
      }
      
      private function __helpHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = null;
         _loc2_ = ComponentFactory.Instance.creatComponentByStylename("childpve.helpFrame");
         _loc2_.show();
      }
      
      private function __openFormationHandler(param1:MouseEvent) : void
      {
         if(_controller.model.childList.length == 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("managers.ChildManager.pickChildTips"));
            return;
         }
         SoundManager.instance.play("022");
         _controller.openFormationFrame();
      }
      
      protected function __SortHandler(param1:MouseEvent) : void
      {
         if(_sortView == null)
         {
            _sortView = ComponentFactory.Instance.creatComponentByStylename("childpve.ChildPveOrderFrame");
            addChild(_sortView);
         }
         else
         {
            _sortView.visible = !_sortView.visible;
            if(_sortView.visible)
            {
               FrameControllerManager.instance.remotePetController.loadRemotePetOrderData();
            }
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_buttonBg);
         _buttonBg = null;
         ObjectUtils.disposeObject(_wantedSkill);
         _wantedSkill = null;
         ObjectUtils.disposeObject(_splitLine);
         _splitLine = null;
         ObjectUtils.disposeObject(_backBorder);
         _backBorder = null;
         ObjectUtils.disposeObject(_allBossBorder);
         _allBossBorder = null;
         ObjectUtils.disposeObject(_childConfigBtn);
         _childConfigBtn = null;
         ObjectUtils.disposeObject(_sortLinkTxt);
         _sortLinkTxt = null;
         ObjectUtils.disposeObject(_tileContainer);
         _tileContainer = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         ObjectUtils.disposeObject(_disEffect);
         _disEffect = null;
         ObjectUtils.disposeObject(_challege);
         _challege = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_sortView);
         _sortView = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uintView();
         super.dispose();
      }
   }
}

