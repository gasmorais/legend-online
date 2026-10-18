package map.campaign.pvp
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.PvpWarFightInfo;
   import map.campaign.data.WarReportInfo;
   import map.campaign.event.PvpWarFightEvent;
   import yishi.manager.NotificationManager;
   
   public class PvpSortListView extends Sprite implements Disposeable
   {
      
      private var _title:MutipleImage;
      
      private var _para0:FilterFrameText;
      
      private var _para1:FilterFrameText;
      
      private var _para2:FilterFrameText;
      
      private var _para3:FilterFrameText;
      
      private var _para4:FilterFrameText;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _bg:ScaleBitmapImage;
      
      private var _failedFlg:Bitmap;
      
      private var _victoryFlg:Bitmap;
      
      private var _mvpMovie:MovieClip;
      
      private var _type:int;
      
      public function PvpSortListView()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _mvpMovie = ComponentFactory.Instance.creatCustomObject("asset.pvpmap.MvpAsset");
         _bg = ComponentFactory.Instance.creatComponentByStylename("pvpmap.SortListBg");
         addChild(_bg);
         _title = ComponentFactory.Instance.creatComponentByStylename("PvpSortListView.Title");
         _para0 = ComponentFactory.Instance.creatComponentByStylename("PvpSortListView.TitleTxt");
         _para1 = ComponentFactory.Instance.creatComponentByStylename("PvpSortListView.TitleTxt");
         _para2 = ComponentFactory.Instance.creatComponentByStylename("PvpSortListView.TitleTxt");
         _para3 = ComponentFactory.Instance.creatComponentByStylename("PvpSortListView.TitleTxt");
         _para4 = ComponentFactory.Instance.creatComponentByStylename("PvpSortListView.TitleTxt");
         addChild(_title);
         addChild(_para0);
         addChild(_para1);
         addChild(_para2);
         addChild(_para3);
         addChild(_para4);
         _para0.text = LanguageMgr.GetTranslation("PvpHeroFrame.PlayerName");
         _para1.text = LanguageMgr.GetTranslation("PvpSortListView.serverName");
         _para2.text = LanguageMgr.GetTranslation("PvpSortListView.jifen");
         _para3.text = LanguageMgr.GetTranslation("PvpSortListView.jisha");
         _para4.text = LanguageMgr.GetTranslation("sort.view.MemberTitleView.honour");
         _para0.x = 35;
         _para0.y = 11;
         _para1.x = 166;
         _para1.y = 11;
         _para2.x = 270;
         _para2.y = 11;
         _para3.x = 347;
         _para3.y = 11;
         _para4.x = 465;
         _para4.y = 11;
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("pvpmap.sortlist.ScrollPanel");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("pvpmap.sortlist.Vbox");
         addChild(_scrollPanel);
         _scrollPanel.setView(_vBox);
         _scrollPanel.x = -3;
         _scrollPanel.y = 36;
         _failedFlg = ComponentFactory.Instance.creatBitmap("asset.core.FailedBitmapAsset");
         _victoryFlg = ComponentFactory.Instance.creatBitmap("asset.core.VictoryBitmapAsset");
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("PVP_WAR_FIGHT_ORDER_REPORT",__updateListHandler);
         __updateListHandler(null);
      }
      
      private function __updateListHandler(param1:PvpWarFightEvent) : void
      {
         var _loc2_:Array = CampaignManager.instance.pvpWarFightModel.warFightOrderList;
         if(!_loc2_)
         {
            return;
         }
         _loc2_ = _loc2_.sortOn("order",0x10 | 2);
         _loc2_ = _loc2_.reverse();
         refreshList(_loc2_);
      }
      
      private function refreshList(param1:Array) : void
      {
         var _loc5_:int = 0;
         var _loc2_:PvpSortItemView = null;
         var _loc4_:int = int(param1.length);
         var _loc6_:int = int(param1.length);
         findMvp(param1);
         param1 = param1.sortOn("score",0x10 | 2);
         var _loc3_:int = _type == 1 ? 10 : 8;
         _loc4_ = int(_loc4_ < _loc3_ ? _loc3_ : param1.length);
         _vBox.beginChanges();
         clearList();
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc2_ = new PvpSortItemView();
            _loc2_.mvp = _mvpMovie;
            _loc2_.bgFrame = _loc5_;
            if(_loc5_ < _loc6_)
            {
               _loc2_.data = param1[_loc5_];
            }
            _vBox.addChild(_loc2_);
            _loc5_++;
         }
         _vBox.commitChanges();
         _scrollPanel.invalidateViewport();
      }
      
      private function findMvp(param1:Array) : void
      {
         if(_type == 1)
         {
            return;
         }
         param1 = param1.sortOn(["hitCount","score"],[0x10 | 2,0x10 | 2]);
         param1[0].isMvp = true;
      }
      
      public function updateSizeByType(param1:int) : void
      {
         _type = param1;
         _scrollPanel.beginChanges();
         _bg.beginChanges();
         if(param1 == 1)
         {
            _scrollPanel.height = 310;
            _bg.height = 352;
            if(_failedFlg && _failedFlg.parent)
            {
               _failedFlg.parent.removeChild(_failedFlg);
            }
            if(_victoryFlg && _victoryFlg.parent)
            {
               _victoryFlg.parent.removeChild(_victoryFlg);
            }
         }
         else if(param1 == 2)
         {
            _scrollPanel.height = 248;
            _bg.height = 287;
            isVictory ? addChild(_victoryFlg) : addChild(_failedFlg);
         }
         _scrollPanel.commitChanges();
         _bg.commitChanges();
         addEvent();
      }
      
      public function get isVictory() : Boolean
      {
         var _loc2_:PvpWarFightInfo = CampaignManager.instance.pvpWarFightModel.pvpWarFightInfo;
         var _loc1_:WarReportInfo = CampaignManager.instance.pvpWarFightModel.fightReportInfo;
         return _loc2_.teamId == _loc1_.oneTeamId;
      }
      
      private function clearList() : void
      {
         var _loc1_:PvpSortItemView = null;
         while(_vBox.numChildren > 0)
         {
            _loc1_ = _vBox.getChildAt(0) as PvpSortItemView;
            if(_loc1_)
            {
               if(_loc1_.parent)
               {
                  _loc1_.parent.removeChild(_loc1_);
               }
               _loc1_.dispose();
            }
            _loc1_ = null;
         }
      }
      
      public function dispose() : void
      {
         NotificationManager.instance.removeEventListener("PVP_WAR_FIGHT_ORDER_REPORT",__updateListHandler);
         if(_title)
         {
            _title.dispose();
         }
         _title = null;
         if(_scrollPanel)
         {
            _scrollPanel.dispose();
         }
         _scrollPanel = null;
         if(_vBox)
         {
            _vBox.dispose();
         }
         _vBox = null;
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         if(_failedFlg)
         {
            ObjectUtils.disposeObject(_failedFlg);
         }
         _failedFlg = null;
         if(_victoryFlg)
         {
            ObjectUtils.disposeObject(_victoryFlg);
         }
         _victoryFlg = null;
         if(_mvpMovie)
         {
            ObjectUtils.disposeObject(_mvpMovie);
         }
         _mvpMovie = null;
         if(_para0)
         {
            ObjectUtils.disposeObject(_para0);
         }
         _para0 = null;
         if(_para1)
         {
            ObjectUtils.disposeObject(_para1);
         }
         _para1 = null;
         if(_para2)
         {
            ObjectUtils.disposeObject(_para2);
         }
         _para2 = null;
         if(_para3)
         {
            ObjectUtils.disposeObject(_para3);
         }
         _para3 = null;
         if(_para4)
         {
            ObjectUtils.disposeObject(_para4);
         }
         _para4 = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

