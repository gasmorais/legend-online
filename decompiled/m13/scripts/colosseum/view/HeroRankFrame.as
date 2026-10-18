package colosseum.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.net.URLVariables;
   import manager.LanguageMgr;
   import managers.ChallengeManager;
   import mvc.controler.ColosseumControler;
   import mvc.module.colosseum.ColosseumModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PathManager;
   
   public class HeroRankFrame extends Frame implements IManualSize
   {
      
      private var _back1:ScaleBitmapImage;
      
      private var _back2:ScaleLeftRightImage;
      
      private var _titleBack:MutipleImage;
      
      private var _rankTxt:FilterFrameText;
      
      private var _nickNameTxt:FilterFrameText;
      
      private var _levelTxt:FilterFrameText;
      
      private var _combatTxt:FilterFrameText;
      
      private var _cancelBtn:SelectedCheckButton;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _group:SelectedButtonGroup;
      
      public function HeroRankFrame()
      {
         super();
         initView();
         if(model.heroRankList.length <= 0)
         {
            getRankList();
         }
         else
         {
            initList();
            initEvent();
         }
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,450,450);
      }
      
      private function getRankList() : void
      {
         var _loc1_:URLVariables = new URLVariables();
         _loc1_["rnd"] = Math.random();
         var _loc2_:String = PathManager.challengPath;
         LoaderManagerII.instance.load(_loc2_,5,8,__onGetRankComplete,null,null,null,_loc1_);
      }
      
      private function __onGetRankComplete(param1:LoaderInfo, param2:Object) : void
      {
         var _loc6_:ThaneInfo = null;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc11_:int = 0;
         if(isDie)
         {
            return;
         }
         var _loc8_:XML = new XML(param2);
         var _loc10_:XMLList = _loc8_..item;
         for each(var _loc4_:XML in _loc10_)
         {
            _loc6_ = new ThaneInfo();
            _loc6_.userId = int(_loc4_.@userId);
            _loc6_.nickName = _loc4_.@nickName;
            _loc6_.grades = int(_loc4_.@grades);
            _loc6_.fightingCapacity = int(_loc4_.@fightingCapacity);
            _loc6_.consortiaName = _loc4_.@consortiaName;
            _loc6_.playerOrdeInfo.gpOrder = int(_loc4_.@order);
            _loc6_.templateId = int(_loc4_.@job);
            _loc6_.challengeRank = int(_loc4_.@curRank);
            _loc6_.IsVipAndNoExpirt = _loc4_.@IsVip == "true" ? true : false;
            for each(var _loc7_:XML in _loc4_..DragonInfo)
            {
               if(int(_loc7_.@Type) > _loc3_)
               {
                  _loc3_ = int(_loc7_.@Type);
                  _loc5_ = int(_loc7_.@Grade);
                  _loc11_ = int(_loc7_.@Gp);
               }
            }
            _loc6_.dragonSoulType = _loc3_;
            _loc6_.dragonSoulGrade = _loc5_;
            _loc6_.dragonSoulGp = _loc11_;
            for each(var _loc9_:XML in _loc4_..TransferInfo)
            {
               _loc6_.vocationGrades = int(_loc9_.@Grade);
               _loc6_.vocationGp = int(_loc9_.@Gp);
            }
            model.heroRankList.push(_loc6_);
         }
         initList();
         initEvent();
      }
      
      private function initView() : void
      {
         _back1 = ComponentFactory.Instance.creatComponentByStylename("colosseum.HeroRankBack1");
         _back2 = ComponentFactory.Instance.creatComponentByStylename("colosseum.HeroRankBack2");
         _titleBack = ComponentFactory.Instance.creatComponentByStylename("colosseum.HeroRankTitleBack");
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("colosseum.HeroRankTxt");
         _nickNameTxt = ComponentFactory.Instance.creatComponentByStylename("colosseum.HeroRankNameTxt");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("colosseum.HeroRankLevelTxt");
         _combatTxt = ComponentFactory.Instance.creatComponentByStylename("colosseum.HeroRankCombatTxt");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("colosseum.HeroRankCancelBtn");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("colosseum.HeroRankScrollPanel");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("colosseum.HeroRankVbox");
         addToContent(_back1);
         addToContent(_back2);
         addToContent(_titleBack);
         addToContent(_rankTxt);
         addToContent(_nickNameTxt);
         addToContent(_levelTxt);
         addToContent(_combatTxt);
         addToContent(_cancelBtn);
         addToContent(_scrollPanel);
         _vBox.spacing = -2;
         _scrollPanel.setView(_vBox);
         _rankTxt.text = LanguageMgr.GetTranslation("colosseum.view.HeroRankFrame.rank");
         _nickNameTxt.text = LanguageMgr.GetTranslation("colosseum.view.HeroRankFrame.nickName");
         _levelTxt.text = LanguageMgr.GetTranslation("public.grade");
         _combatTxt.text = LanguageMgr.GetTranslation("public.playerInfo.ap");
         _cancelBtn.text = LanguageMgr.GetTranslation("public.close");
      }
      
      private function initList() : void
      {
         var _loc3_:int = 0;
         var _loc1_:HeroRankItem = null;
         _group = new SelectedButtonGroup();
         var _loc2_:int = int(model.heroRankList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = new HeroRankItem();
            _loc1_.data = model.heroRankList[_loc3_];
            _vBox.addChild(_loc1_);
            _group.addSelectItem(_loc1_);
            _loc3_++;
         }
         _scrollPanel.invalidateViewport();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _cancelBtn.addEventListener("click",__closeHandler);
         _group.addEventListener("change",__selectedItemChangeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _cancelBtn.removeEventListener("click",__closeHandler);
         _group.removeEventListener("change",__selectedItemChangeHandler);
      }
      
      private function __selectedItemChangeHandler(param1:Event) : void
      {
      }
      
      private function __closeHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         control.closeRankFrame();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               control.closeRankFrame();
         }
      }
      
      private function get model() : ColosseumModel
      {
         return ChallengeManager.instance.model;
      }
      
      private function get control() : ColosseumControler
      {
         return FrameControllerManager.instance.colosseumControler;
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("colosseum.view.HeroRankFrame.title");
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__onGetRankComplete);
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

