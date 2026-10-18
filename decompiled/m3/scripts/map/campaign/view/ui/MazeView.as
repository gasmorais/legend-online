package map.campaign.view.ui
{
   import chat.view.ChatItemMenu;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.view.frame.MazeFallItemsFrame;
   import mvc.module.maze.MazeModel;
   import yishi.datas.VersionSwitch;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.TowerInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.MsgMan;
   import yishi.utils.StringHelper;
   import yishi.utils.WorldBossHelper;
   import yishi.view.community.BaseItemView;
   
   public class MazeView extends Sprite implements Disposeable
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _currentFloor:FilterFrameText;
      
      private var _currentValue:FilterFrameText;
      
      private var _totalExp:FilterFrameText;
      
      private var _totalExpValue:FilterFrameText;
      
      private var _fallItemsTxt:FilterFrameText;
      
      private var _shopBtn:BaseButton;
      
      private var _autoBtn:IconButton;
      
      private var _stopAutoBtn:IconButton;
      
      private var _firstBloodImg:Bitmap;
      
      private var _firstBloodNameTxt:GradientText;
      
      private var _hbox:SimpleTileList;
      
      private var _panel:ScrollPanel;
      
      private var _bgInitHeight:int;
      
      private var autoHelper:MazeAutoFightHelper;
      
      private var _menu:ChatItemMenu;
      
      private var _totalCount:int;
      
      private var _items:Array = [];
      
      public function MazeView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("maze.mazeInfoViewBackgroud");
         _shopBtn = ComponentFactory.Instance.creatComponentByStylename("maze.MazeSmallShopBtn");
         _currentFloor = ComponentFactory.Instance.creatComponentByStylename("maze.campaign.CurLayerTxt");
         _currentFloor.text = LanguageMgr.GetTranslation("map.campaign.view.ui.MazeView.current");
         _totalExp = ComponentFactory.Instance.creatComponentByStylename("maze.campaign.TotalGpTxt");
         _totalExp.text = LanguageMgr.GetTranslation("map.campaign.view.ui.MazeView.totalExp");
         _currentValue = ComponentFactory.Instance.creatComponentByStylename("maze.campaign.CurLayerValueTxt");
         _currentValue.text = "" + towerInfo.towerIndex;
         _totalExpValue = ComponentFactory.Instance.creatComponentByStylename("maze.campaign.TotalGpValueTxt");
         _totalExpValue.text = "" + towerInfo.totalGp;
         _fallItemsTxt = ComponentFactory.Instance.creatComponentByStylename("maze.campaign.FallItemsLinkTxt");
         _fallItemsTxt.htmlText = LanguageMgr.GetTranslation("map.campaign.view.ui.MazeView.fallItems");
         _fallItemsTxt.mouseEnabled = true;
         _hbox = ComponentFactory.Instance.creatCustomObject("maze.campaign.fallGoodsList",[3]);
         _autoBtn = ComponentFactory.Instance.creatComponentByStylename("maze.MazeView.autoBtn");
         _stopAutoBtn = ComponentFactory.Instance.creatComponentByStylename("maze.MazeView.stopAutoBtn");
         _panel = ComponentFactory.Instance.creatComponentByStylename("maze.campaign.fallGoodsPanel");
         _panel.beginChanges();
         _panel.setView(_hbox);
         _panel.commitChanges();
         _panel.invalidateViewport();
         addChild(_back);
         if(VersionSwitch.MAZE_FIRST_KILL && Boolean(WorldBossHelper.checkMaze2(towerInfo.campaignId)))
         {
            _firstBloodImg = ComponentFactory.Instance.creatBitmap("asset.maze.FirstBlood");
            _firstBloodNameTxt = ComponentFactory.Instance.creatComponentByStylename("maze.FirstBloodText");
            _firstBloodNameTxt.mouseEnabled = false;
            if(!StringHelper.isNullOrEmpty(towerInfo.firstBloodName))
            {
               _firstBloodNameTxt.mouseEnabled = true;
               _firstBloodNameTxt.textField.width = _firstBloodNameTxt.textWidth + 4;
               _firstBloodNameTxt.width = _firstBloodNameTxt.textField.width;
               _firstBloodNameTxt.buttonMode = true;
               _firstBloodNameTxt.text = towerInfo.firstBloodName;
            }
            addChild(_firstBloodImg);
            addChild(_firstBloodNameTxt);
         }
         addChild(_currentFloor);
         addChild(_totalExp);
         addChild(_currentValue);
         addChild(_totalExpValue);
         addChild(_fallItemsTxt);
         addChild(_panel);
         addChild(_shopBtn);
         if(ArmyManager.instance.thane.grades >= 15)
         {
            addChild(_autoBtn);
            addChild(_stopAutoBtn);
            autoHelper = new MazeAutoFightHelper();
            __updateAutoStateHandler("",null);
         }
         _bgInitHeight = _back.height;
         refreshGoods();
      }
      
      private function addEvent() : void
      {
         _panel.addEventListener("rollOver",__mouseOverHandler);
         _panel.addEventListener("rollOut",__mouseOutHandler);
         _shopBtn.addEventListener("click",__onShopClick);
         _autoBtn.addEventListener("click",__onAutoClick);
         _stopAutoBtn.addEventListener("click",__onStopAutoClick);
         _fallItemsTxt.addEventListener("click",__onLinkHandler);
         _firstBloodNameTxt && _firstBloodNameTxt.addEventListener("click",__showMenu);
         PlayerManager.instance.addEventListener("UPDATE_TOWER_INFO",__onTowerChange);
         MsgMan.addObserver("REFRESH_AUTO_STATE",this,__updateAutoStateHandler);
      }
      
      private function removeEvent() : void
      {
         if(_panel)
         {
            _panel.removeEventListener("rollOver",__mouseOverHandler);
            _panel.removeEventListener("rollOut",__mouseOutHandler);
         }
         if(_shopBtn)
         {
            _shopBtn.removeEventListener("click",__onShopClick);
         }
         if(_fallItemsTxt)
         {
            _fallItemsTxt.removeEventListener("click",__onLinkHandler);
         }
         if(_autoBtn)
         {
            _autoBtn.removeEventListener("click",__onAutoClick);
         }
         if(_autoBtn)
         {
            _stopAutoBtn.removeEventListener("click",__onStopAutoClick);
         }
         _firstBloodNameTxt && _firstBloodNameTxt.removeEventListener("click",__showMenu);
         PlayerManager.instance.removeEventListener("UPDATE_TOWER_INFO",__onTowerChange);
         MsgMan.removeObserver("REFRESH_AUTO_STATE",this,__updateAutoStateHandler);
      }
      
      private function __onAutoClick(param1:MouseEvent) : void
      {
         MazeModel.instance.isAuto = true;
      }
      
      private function __onStopAutoClick(param1:MouseEvent) : void
      {
         MazeModel.instance.isAuto = false;
      }
      
      private function __updateAutoStateHandler(param1:String, param2:Object) : void
      {
         if(ArmyManager.instance.thane.grades < 15)
         {
            return;
         }
         _autoBtn.visible = !MazeModel.instance.isAuto;
         _stopAutoBtn.visible = MazeModel.instance.isAuto;
         if(autoHelper)
         {
            if(MazeModel.instance.isAuto)
            {
               autoHelper.start();
            }
            else
            {
               autoHelper.stop();
            }
         }
      }
      
      private function __onShopClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("shop",4);
      }
      
      private function __showMenu(param1:MouseEvent) : void
      {
         var _loc2_:GradientText = param1.currentTarget as GradientText;
         if(_menu)
         {
            _menu.dispose();
         }
         _menu = new ChatItemMenu(towerInfo.firstBloodName,towerInfo.firstBloodId,false);
         LayerManager.Instance.addToLayer(_menu,7);
         _menu.x = _loc2_.x + _loc2_.textField.textWidth + 5;
         _menu.y = _loc2_.y + _loc2_.textField.height + 25;
      }
      
      private function __onTowerChange(param1:PlayerEvent) : void
      {
         _currentValue.text = "" + PlayerManager.instance.currentPlayerModel.towerInfo.towerIndex;
         _totalExpValue.text = "" + PlayerManager.instance.currentPlayerModel.towerInfo.totalGp;
         refreshGoods();
      }
      
      private function __onLinkHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:MazeFallItemsFrame = ComponentFactory.Instance.creatComponentByStylename("campaign.maze.FallItemsFrame");
         _loc2_.show(this);
         _loc2_.data = "";
      }
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
         refreshCell(Math.ceil(_totalCount / 3));
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         refreshCell(1);
      }
      
      private function refreshGoods() : void
      {
         var _loc3_:int = 0;
         var _loc1_:BaseItemView = null;
         var _loc5_:GoodsInfo = null;
         var _loc2_:String = CampaignManager.instance.mapModel.campaignTemplate.Item;
         var _loc4_:Array = _loc2_.split(",");
         if(_loc2_ == "")
         {
            _totalCount = 0;
            if(_panel.parent)
            {
               _panel.parent.removeChild(_panel);
            }
         }
         else
         {
            _totalCount = _loc4_.length;
            _loc3_ = 0;
            while(_loc3_ < _loc4_.length)
            {
               _loc1_ = ComponentFactory.Instance.creatCustomObject("core.fallGoods.BaseItemView");
               _items.push(_loc1_);
               if(!(_loc4_[_loc3_] == null || _loc4_[_loc3_] == ""))
               {
                  _loc5_ = new GoodsInfo();
                  _loc5_.templateId = _loc4_[_loc3_];
                  _loc1_.data = _loc5_;
               }
               _loc3_++;
            }
         }
         refreshCell(1);
      }
      
      private function refreshCell(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc2_:BaseItemView = null;
         _back.beginChanges();
         var _loc3_:int = param1 > 1 ? 79 : 24;
         if(_totalCount == 0)
         {
            _loc3_ = -80;
         }
         _back.height = _bgInitHeight + _loc3_;
         _back.commitChanges();
         _panel.beginChanges();
         _panel.height = param1 > 1 ? 100 : 50;
         _hbox.beginChanges();
         _hbox.removeAllChild();
         param1 = 3 * param1;
         _loc4_ = 0;
         while(_loc4_ < param1)
         {
            _loc2_ = _items[_loc4_] as BaseItemView;
            if(!(!_loc2_ || !_loc2_.data))
            {
               _hbox.addChild(_loc2_);
            }
            _loc4_++;
         }
         _hbox.commitChanges();
         _panel.commitChanges();
         _panel.invalidateViewport();
      }
      
      private function get towerInfo() : TowerInfo
      {
         var _loc1_:int = int(CampaignManager.instance.mapModel.mapId);
         if(WorldBossHelper.checkMaze(_loc1_))
         {
            return PlayerManager.instance.currentPlayerModel.towerInfo1;
         }
         if(WorldBossHelper.checkMaze2(_loc1_))
         {
            return PlayerManager.instance.currentPlayerModel.towerInfo2;
         }
         return PlayerManager.instance.currentPlayerModel.towerInfo;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_back)
         {
            _back.dispose();
         }
         _back = null;
         if(_shopBtn)
         {
            _shopBtn.dispose();
         }
         _shopBtn = null;
         if(_currentFloor)
         {
            _currentFloor.dispose();
         }
         _currentFloor = null;
         if(_currentValue)
         {
            _currentValue.dispose();
         }
         _currentValue = null;
         if(_totalExp)
         {
            _totalExp.dispose();
         }
         _totalExp = null;
         if(_totalExpValue)
         {
            _totalExpValue.dispose();
         }
         _totalExpValue = null;
         if(_fallItemsTxt)
         {
            _fallItemsTxt.dispose();
         }
         _fallItemsTxt = null;
         if(_firstBloodImg)
         {
            if(_firstBloodImg.parent)
            {
               _firstBloodImg.parent.removeChild(_firstBloodImg);
            }
            _firstBloodImg.bitmapData.dispose();
            _firstBloodImg = null;
         }
         if(_firstBloodNameTxt)
         {
            _firstBloodNameTxt.dispose();
         }
         _firstBloodNameTxt = null;
         if(_hbox)
         {
            _hbox.dispose();
         }
         _hbox = null;
         if(_panel)
         {
            _panel.dispose();
         }
         _panel = null;
         if(_autoBtn)
         {
            ObjectUtils.disposeObject(_autoBtn);
         }
         _autoBtn = null;
         if(_stopAutoBtn)
         {
            ObjectUtils.disposeObject(_stopAutoBtn);
         }
         _stopAutoBtn = null;
         if(autoHelper)
         {
            autoHelper.dispose();
         }
         autoHelper = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

