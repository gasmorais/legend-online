package map.campaign.view.ui.flametemple
{
   import chat.view.ChatItemMenu;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.ui.Mouse;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.PvpWarFightModel;
   import map.campaign.data.WarFightOrderInfo;
   import map.campaign.event.PvpWarFightEvent;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.PlayerManager;
   import yishi.scene.SceneManager;
   
   public class FlameTempleScoreRankView extends Frame implements IManualSize
   {
      
      private var _border:ScaleBitmapImage;
      
      private var _back:Scale9CornerImage;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _itemList:Array = [];
      
      private var _model:PvpWarFightModel;
      
      private var _selectedItem:FlameTempleScoreRankItemView;
      
      private var _menu:ChatItemMenu;
      
      private var _rect:Rectangle = new Rectangle(0,0,655,425);
      
      public function FlameTempleScoreRankView()
      {
         super();
         _model = CampaignManager.instance.pvpWarFightModel;
         initView();
         addEvent();
         update();
      }
      
      private function initView() : void
      {
         var _loc7_:int = 0;
         var _loc1_:FilterFrameText = null;
         var _loc6_:int = 0;
         var _loc2_:FlameTempleScoreRankItemView = null;
         _border = ComponentFactory.Instance.creatComponentByStylename("flameTempleScoreRankView.border");
         _back = ComponentFactory.Instance.creatComponentByStylename("flameTempleScoreRankView.back");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("flameTempleScoreRankView.scrollPanel");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("flameTempleScoreRankView.vBox");
         var _loc3_:Array = [LanguageMgr.GetTranslation("colosseum.view.HeroRankFrame.rank"),LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanElection.title1"),LanguageMgr.GetTranslation("PvpSortListView.serverName"),LanguageMgr.GetTranslation("petchallenge.PetChallengeTopFrame.ScoreTitleTxt"),LanguageMgr.GetTranslation("flameTempleScoreRankView.jisha"),LanguageMgr.GetTranslation("map.campaign.pvp.PvpSettlementAwardView.honorBit.tipData")];
         var _loc4_:Array = [98,90,190,40,50,100];
         var _loc8_:Array = [0,98,188,365,435,500];
         var _loc5_:Component = new Component();
         _loc5_.y = 12;
         _loc7_ = 0;
         while(_loc7_ < _loc3_.length)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("flameTempleScoreRankView.titleTxt");
            _loc1_.width = _loc4_[_loc7_];
            _loc1_.x = _loc8_[_loc7_];
            _loc1_.text = _loc3_[_loc7_];
            _loc5_.addChild(_loc1_);
            _loc7_++;
         }
         _loc6_ = 0;
         while(_loc6_ < 30)
         {
            _loc2_ = new FlameTempleScoreRankItemView();
            _itemList.push(_loc2_);
            if(_loc6_ < 9)
            {
               _vBox.addChild(_loc2_);
            }
            _loc6_++;
         }
         _scrollPanel.setView(_vBox);
         _scrollPanel.invalidateViewport();
         addToContent(_border);
         addToContent(_back);
         addToContent(_scrollPanel);
         addToContent(_loc5_);
         _vBox.mouseEnabled = false;
         this.titleText = LanguageMgr.GetTranslation("map.campaign.pvp.title01");
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_menu);
         _menu = null;
      }
      
      private function addEvent() : void
      {
         this.addEventListener("response",__frameResponse);
         _vBox.addEventListener("mouseOut",__onItemMouseOutHandler);
         _vBox.addEventListener("mouseOver",__onItemMouseOverHandler);
         _vBox.addEventListener("click",__onItemClickHandler);
         _model.addEventListener("PVP_WAR_FIGHT_ORDER_REPORT",__refreshRankHandler);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("response",__frameResponse);
         if(_vBox)
         {
            _vBox.removeEventListener("mouseOut",__onItemMouseOutHandler);
            _vBox.removeEventListener("mouseOver",__onItemMouseOverHandler);
            _vBox.removeEventListener("click",__onItemClickHandler);
         }
         if(_model)
         {
            _model.removeEventListener("PVP_WAR_FIGHT_ORDER_REPORT",__refreshRankHandler);
         }
      }
      
      private function __onItemMouseOutHandler(param1:MouseEvent) : void
      {
         var _loc2_:FlameTempleScoreRankItemView = null;
         if(param1.target is FlameTempleScoreRankItemView)
         {
            _loc2_ = param1.target as FlameTempleScoreRankItemView;
            _loc2_.mouseOut();
         }
         else if(param1.target is TextField)
         {
            Mouse.cursor = "auto";
         }
      }
      
      private function __onItemMouseOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:FlameTempleScoreRankItemView = null;
         if(param1.target is FlameTempleScoreRankItemView)
         {
            _loc2_ = param1.target as FlameTempleScoreRankItemView;
         }
         else if(param1.target is TextField)
         {
            _loc2_ = (param1.target as TextField).parent as FlameTempleScoreRankItemView;
            Mouse.cursor = "button";
         }
         if(_loc2_)
         {
            _loc2_.mouseOver();
         }
      }
      
      private function __onItemClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:FlameTempleScoreRankItemView = null;
         if(param1.target is FlameTempleScoreRankItemView)
         {
            _loc2_ = param1.target as FlameTempleScoreRankItemView;
            if(_selectedItem)
            {
               _selectedItem.selected = false;
            }
            _selectedItem = _loc2_;
            _selectedItem.selected = true;
         }
         else if(param1.target is TextField)
         {
            _loc2_ = (param1.target as TextField).parent as FlameTempleScoreRankItemView;
            onLinkClick(_loc2_.data);
         }
      }
      
      private function onLinkClick(param1:WarFightOrderInfo) : void
      {
         if(_menu)
         {
            _menu.dispose();
         }
         _menu = null;
         if(!param1)
         {
            return;
         }
         var _loc4_:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         var _loc5_:String = _loc4_.serviceName;
         var _loc2_:Boolean = _loc5_ != param1.serverName;
         var _loc3_:Boolean = false;
         _menu = new ChatItemMenu(param1.nickName,param1.userId,_loc3_,param1.serverName,false,false,false,false,false);
         if(SceneManager.instance.currentType == "CASTLE_SCENE")
         {
            if(_loc2_)
            {
               _menu.enablePlayerInfoButton(false);
            }
         }
         LayerManager.Instance.addToLayer(_menu,7);
         _menu.x = StageReferance.stage.mouseX;
         _menu.y = StageReferance.stage.mouseY + 7;
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
      
      private function __refreshRankHandler(param1:PvpWarFightEvent) : void
      {
         update();
      }
      
      public function update() : void
      {
         var _loc3_:int = 0;
         var _loc1_:FlameTempleScoreRankItemView = null;
         var _loc4_:Array = _model.getTeamRank();
         _vBox.removeAllChild();
         var _loc2_:int = int(_loc4_.length > 9 ? _loc4_.length : 9);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _itemList[_loc3_] as FlameTempleScoreRankItemView;
            if(_loc1_)
            {
               _loc1_.data = _loc4_[_loc3_];
               _vBox.addChild(_loc1_);
            }
            _loc3_++;
         }
         _scrollPanel.invalidateViewport();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return _rect;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uintView();
         super.dispose();
         _model = null;
         Mouse.cursor = "auto";
      }
   }
}

