package skytreasure
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.SkyTreasureEvent;
   import manager.LanguageMgr;
   import mvc.module.skytreasure.SkyTreasureModelNew;
   import yishi.manager.SkyTreasureManager;
   
   public class SkyTreasureRankView1 extends Component
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _rankScroll:ScrollPanel;
      
      private var _myRankText:FilterFrameText;
      
      private var _myScoreText:FilterFrameText;
      
      private var _rankItemArray:Array;
      
      private var _currentActId:String = "";
      
      public function SkyTreasureRankView1()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("skyTreasure.RankViewBack");
         _rankScroll = ComponentFactory.Instance.creatComponentByStylename("skyTreasure.RankScroll");
         _myRankText = ComponentFactory.Instance.creatComponentByStylename("skyTreasure.MyRankText");
         _myScoreText = ComponentFactory.Instance.creatComponentByStylename("skyTreasure.MyScoreText");
         addChild(_back);
         addChild(_rankScroll);
         addChild(_myRankText);
         addChild(_myScoreText);
         _rankItemArray = [];
      }
      
      private function initEvent() : void
      {
         SkyTreasureManager.Instance.addEventListener("SKY_TREASURE_RANKINFO_UPDATE",__onRankDataUpdate);
         SkyTreasureManager.Instance.addEventListener("SKY_TREASURE_RANKHISTORY_UPDATE",__onRankHistoryUpdate);
      }
      
      private function removeEvent() : void
      {
         SkyTreasureManager.Instance.removeEventListener("SKY_TREASURE_RANKINFO_UPDATE",__onRankDataUpdate);
         SkyTreasureManager.Instance.removeEventListener("SKY_TREASURE_RANKHISTORY_UPDATE",__onRankHistoryUpdate);
      }
      
      public function setCurrentActId(param1:String) : void
      {
         _currentActId = param1;
         updateRankList();
      }
      
      private function updateRankList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:SkyTreasureModelNew = SkyTreasureManager.Instance.modelNew;
         if(!_loc2_)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < _rankItemArray.length)
         {
            if(_rankItemArray[_loc1_])
            {
               ObjectUtils.disposeObject(_rankItemArray[_loc1_]);
            }
            _loc1_++;
         }
         _rankItemArray = [];
         updateMyRank();
      }
      
      private function updateMyRank() : void
      {
         _myRankText.text = LanguageMgr.GetTranslation("skyTreasure.myRank",0);
         _myScoreText.text = "0";
      }
      
      private function __onRankDataUpdate(param1:SkyTreasureEvent) : void
      {
         updateRankList();
      }
      
      private function __onRankHistoryUpdate(param1:SkyTreasureEvent) : void
      {
         updateRankList();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_rankScroll);
         _rankScroll = null;
         ObjectUtils.disposeObject(_myRankText);
         _myRankText = null;
         ObjectUtils.disposeObject(_myScoreText);
         _myScoreText = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

