package skytreasure.rank
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.skytreasure.SkyTreasureRankRecordInfo;
   
   public class SkyTreasureHistoryrankDayItem extends Sprite
   {
      
      protected var _ExchangeItemBg:Bitmap;
      
      protected var _myhisRankname:FilterFrameText;
      
      protected var _myhisRank:FilterFrameText;
      
      protected var _tongguanhuawen1:Bitmap;
      
      protected var _tongguanhuawen2:Bitmap;
      
      protected var _hisranktime:FilterFrameText;
      
      private var _showInfoPanel:ScrollPanel;
      
      private var _showVBox:VBox;
      
      private var _my:Sprite;
      
      private var _data:SkyTreasureRankRecordInfo;
      
      public function SkyTreasureHistoryrankDayItem()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _ExchangeItemBg = ComponentFactory.Instance.creatBitmap("asset.skyTreasure.ExchangeItemBg");
         _my = new Sprite();
         _myhisRankname = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.myhisRankname");
         _myhisRank = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.myhisRank");
         _tongguanhuawen1 = ComponentFactory.Instance.creatBitmap("asset.skyTreasure.tongguanhuawen1");
         _tongguanhuawen2 = ComponentFactory.Instance.creatBitmap("asset.skyTreasure.tongguanhuawen2");
         _hisranktime = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.hisranktime");
         addChild(_ExchangeItemBg);
         _showVBox = ComponentFactory.Instance.creatComponentByStylename("lottery.ShowInfoVBox");
         _myhisRankname.text = LanguageMgr.GetTranslation("SkyTreasureCoinRewardFrame.txt1");
         addChild(_showVBox);
         _showVBox.y = 40;
         _my.addChild(_myhisRankname);
         _my.addChild(_myhisRank);
         addChild(_tongguanhuawen1);
         addChild(_tongguanhuawen2);
         addChild(_hisranktime);
      }
      
      public function set data(param1:SkyTreasureRankRecordInfo) : void
      {
         var _loc2_:int = 0;
         var _loc3_:SkyTreasureHistoryrankItem = null;
         _data = param1;
         _hisranktime.text = _data.desc;
         _myhisRank.text = _data.rankDesc;
         _showVBox.removeAllChild();
         _showVBox.disposeAllChildren();
         _showVBox.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < _data.rankInfoArray.length)
         {
            _loc3_ = new SkyTreasureHistoryrankItem();
            _loc3_.data = _data.rankInfoArray[_loc2_];
            _showVBox.addChild(_loc3_);
            _loc2_++;
         }
         _showVBox.addChild(_my);
         _showVBox.commitChanges();
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_ExchangeItemBg);
         _ExchangeItemBg = null;
         ObjectUtils.disposeObject(_myhisRankname);
         _myhisRankname = null;
         ObjectUtils.disposeObject(_myhisRank);
         _myhisRank = null;
         ObjectUtils.disposeObject(_tongguanhuawen1);
         _tongguanhuawen1 = null;
         ObjectUtils.disposeObject(_tongguanhuawen2);
         _tongguanhuawen2 = null;
         ObjectUtils.disposeObject(_hisranktime);
         _hisranktime = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

