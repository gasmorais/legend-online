package consortia.view.fb
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import consortia.view.fb.item.GuildFBRankItem;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.guildfb.GuildFBModel;
   import mvc.module.guildfb.GuildFBRankItemInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.MsgMan;
   
   public class GuildFBRankFrame extends Frame
   {
      
      public static const PAGE_NUMBER:int = 7;
      
      private var _bg:Image;
      
      private var _rankTxt:FilterFrameText;
      
      private var _guildNameTxt:FilterFrameText;
      
      private var _currentLevelTxt:FilterFrameText;
      
      private var _progressTxt:FilterFrameText;
      
      private var _seasonRewardTxt:FilterFrameText;
      
      private var _pageBg:Image;
      
      private var _pageTxt:FilterFrameText;
      
      private var _preBtn:IconButton;
      
      private var _nextBtn:IconButton;
      
      private var _guildbg:Image;
      
      private var _guildInNameTxt:FilterFrameText;
      
      private var _rankImg:Image;
      
      private var _rankTxtBg:ScaleLeftRightImage;
      
      private var _selfRankTxt:FilterFrameText;
      
      private var _lastUpdateTimeTxt:FilterFrameText;
      
      private var _vBox:VBox;
      
      private var _totalPage:int;
      
      private var _currentPage:int;
      
      private var _itemList:Vector.<GuildFBRankItem>;
      
      public function GuildFBRankFrame()
      {
         super();
         FrameControllerManager.instance.guildFbController.loadXML();
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("guildFBRankFrame.bg");
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("guildFBRankFrame.pageBg");
         _guildbg = ComponentFactory.Instance.creatComponentByStylename("guildFBRankFrame.guildbg");
         _rankImg = ComponentFactory.Instance.creatComponentByStylename("guildFBRankFrame.rankImg");
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("guildFBRankFrame.rankTxt");
         _guildNameTxt = ComponentFactory.Instance.creatComponentByStylename("guildFBRankFrame.guildNameTxt");
         _currentLevelTxt = ComponentFactory.Instance.creatComponentByStylename("guildFBRankFrame.currentLevelTxt");
         _progressTxt = ComponentFactory.Instance.creatComponentByStylename("guildFBRankFrame.progressTxt");
         _seasonRewardTxt = ComponentFactory.Instance.creatComponentByStylename("guildFBRankFrame.seasonRewardTxt");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("guildFBRankFrame.pageTxt");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("guildFBRankFrame.preBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("guildFBRankFrame.nextBtn");
         _guildInNameTxt = ComponentFactory.Instance.creatComponentByStylename("guildFBRankFrame.guildInNameTxt");
         _rankTxtBg = ComponentFactory.Instance.creatComponentByStylename("guildFBRankFrame.rankTxtBg");
         _selfRankTxt = ComponentFactory.Instance.creatComponentByStylename("guildFBRankFrame.selfRankTxt");
         _lastUpdateTimeTxt = ComponentFactory.Instance.creatComponentByStylename("guildFBRankFrame.lastUpdateTimeTxt");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("guildFBRankFrame.vBox");
         addToContent(_bg);
         addToContent(_pageBg);
         addToContent(_guildbg);
         addToContent(_rankImg);
         addToContent(_rankTxt);
         addToContent(_guildNameTxt);
         addToContent(_currentLevelTxt);
         addToContent(_progressTxt);
         addToContent(_seasonRewardTxt);
         addToContent(_pageTxt);
         addToContent(_preBtn);
         addToContent(_nextBtn);
         addToContent(_guildInNameTxt);
         addToContent(_rankTxtBg);
         addToContent(_selfRankTxt);
         addToContent(_lastUpdateTimeTxt);
         addToContent(_vBox);
         _rankTxt.text = LanguageMgr.GetTranslation("consortia.view.fb.guildFBRankFrame.rankTxt");
         _guildNameTxt.text = LanguageMgr.GetTranslation("consortia.view.fb.guildFBRankFrame.guildNameTxt");
         _currentLevelTxt.text = LanguageMgr.GetTranslation("consortia.view.fb.guildFBRankFrame.currentLevelTxt");
         _selfRankTxt.text = LanguageMgr.GetTranslation("colosseum.view.ColosseumPlayerItem.newPeople");
         _lastUpdateTimeTxt.text = "";
      }
      
      private function unInitView() : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_pageBg)
         {
            ObjectUtils.disposeObject(_pageBg);
         }
         _pageBg = null;
         if(_guildbg)
         {
            ObjectUtils.disposeObject(_guildbg);
         }
         _guildbg = null;
         if(_rankImg)
         {
            ObjectUtils.disposeObject(_rankImg);
         }
         _rankImg = null;
         if(_rankTxt)
         {
            ObjectUtils.disposeObject(_rankTxt);
         }
         _rankTxt = null;
         if(_guildNameTxt)
         {
            ObjectUtils.disposeObject(_guildNameTxt);
         }
         _guildNameTxt = null;
         if(_currentLevelTxt)
         {
            ObjectUtils.disposeObject(_currentLevelTxt);
         }
         _currentLevelTxt = null;
         if(_progressTxt)
         {
            ObjectUtils.disposeObject(_progressTxt);
         }
         _progressTxt = null;
         if(_seasonRewardTxt)
         {
            ObjectUtils.disposeObject(_seasonRewardTxt);
         }
         _seasonRewardTxt = null;
         if(_pageTxt)
         {
            ObjectUtils.disposeObject(_pageTxt);
         }
         _pageTxt = null;
         if(_preBtn)
         {
            ObjectUtils.disposeObject(_preBtn);
         }
         _preBtn = null;
         if(_nextBtn)
         {
            ObjectUtils.disposeObject(_nextBtn);
         }
         _nextBtn = null;
         if(_guildInNameTxt)
         {
            ObjectUtils.disposeObject(_guildInNameTxt);
         }
         _guildInNameTxt = null;
         if(_rankTxtBg)
         {
            ObjectUtils.disposeObject(_rankTxtBg);
         }
         _rankTxtBg = null;
         if(_selfRankTxt)
         {
            ObjectUtils.disposeObject(_selfRankTxt);
         }
         _selfRankTxt = null;
         if(_lastUpdateTimeTxt)
         {
            ObjectUtils.disposeObject(_lastUpdateTimeTxt);
         }
         _lastUpdateTimeTxt = null;
         if(_vBox)
         {
            ObjectUtils.disposeObject(_vBox);
         }
         _vBox = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         if(_preBtn)
         {
            _preBtn.addEventListener("click",__pageBtnHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.addEventListener("click",__pageBtnHandler);
         }
         MsgMan.addObserver("RANK_UPDATE",this,__rankUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_preBtn)
         {
            _preBtn.removeEventListener("click",__pageBtnHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.removeEventListener("click",__pageBtnHandler);
         }
         MsgMan.removeObserver("RANK_UPDATE",this,__rankUpdateHandler);
      }
      
      private function refreshView() : void
      {
         if(model.raceNode.state == 1)
         {
            _progressTxt.visible = true;
            _seasonRewardTxt.visible = false;
            _progressTxt.text = LanguageMgr.GetTranslation("consortia.view.fb.guildFBRankFrame.progressTxt");
         }
         else if(model.raceNode.state == 2)
         {
            _progressTxt.visible = false;
            _seasonRewardTxt.visible = true;
            _seasonRewardTxt.text = LanguageMgr.GetTranslation("consortia.view.fb.guildFBRankFrame.seasonRewardTxt");
         }
         _guildInNameTxt.text = FrameControllerManager.instance.consortiaController.model.consortiaInfo.consortiaName + "    " + model.currFightNode.currTempInfo.Name;
         _pageTxt.text = model.currentPage + "/" + model.totalPage;
         initVox();
      }
      
      private function initVox() : void
      {
         var _loc2_:int = 0;
         var _loc1_:GuildFBRankItem = null;
         if(_vBox)
         {
            _vBox.removeAllChild();
         }
         _itemList = new Vector.<GuildFBRankItem>();
         if(model.raceNode.state == 1)
         {
            _vBox.spacing = 18;
         }
         else if(model.raceNode.state == 2)
         {
            _vBox.spacing = 7;
         }
         _loc2_ = 0;
         while(_loc2_ < 7)
         {
            _loc1_ = new GuildFBRankItem();
            _itemList.push(_loc1_);
            _vBox.addChild(_loc1_);
            _loc2_++;
         }
      }
      
      private function refreshVbox() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:Array = model.rankArray;
         model.totalPage = Math.ceil(_loc1_.length / 7);
         _loc3_ = 0;
         while(_loc3_ < _itemList.length)
         {
            _loc2_ = _loc3_ + (model.currentPage - 1) * 7;
            if(_loc2_ < _loc1_.length)
            {
               _itemList[_loc3_].data = _loc1_[_loc2_] as GuildFBRankItemInfo;
            }
            else
            {
               _itemList[_loc3_].data = null;
            }
            _loc3_++;
         }
         _vBox.commitChanges();
         _selfRankTxt.text = getPlayerRankInfo();
         _pageTxt.text = model.currentPage + "/" + model.totalPage;
         _lastUpdateTimeTxt.text = LanguageMgr.GetTranslation("consortia.view.fb.guildFBRankFrame.lastUpdateTimeTxt",model.lastRefreshTime);
      }
      
      private function getPlayerRankInfo() : String
      {
         var _loc3_:int = int(playerInfo.consortiaID);
         var _loc2_:String = model.serverName;
         var _loc4_:Array = model.rankArray;
         var _loc5_:String = LanguageMgr.GetTranslation("colosseum.view.ColosseumPlayerItem.newPeople");
         for each(var _loc1_:GuildFBRankItemInfo in _loc4_)
         {
            if(_loc1_.serverName == _loc2_ && _loc1_.consortiaId == _loc3_)
            {
               _loc5_ = _loc1_.order.toString();
            }
         }
         return _loc5_;
      }
      
      private function __rankUpdateHandler(param1:String, param2:Object) : void
      {
         refreshVbox();
         setPageBtnEnable();
      }
      
      private function setPageBtnEnable() : void
      {
         _preBtn.enable = model.currentPage > 1;
         _nextBtn.enable = model.currentPage < model.totalPage;
      }
      
      private function __pageBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(param1.currentTarget == _preBtn && model.currentPage > 1)
         {
            model.currentPage--;
         }
         else if(param1.currentTarget != _preBtn && model.currentPage < model.totalPage)
         {
            model.currentPage++;
         }
      }
      
      private function get model() : GuildFBModel
      {
         return FrameControllerManager.instance.guildFbController.model;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("consortia.view.fb.guildFBRankFrame.titleTxt");
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         unInitView();
         ObjectUtils.disposeAllChildren(this);
         KeyBoardRegister.instance.keyEnable = true;
      }
   }
}

