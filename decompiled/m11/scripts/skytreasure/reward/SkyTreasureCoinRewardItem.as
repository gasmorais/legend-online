package skytreasure.reward
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.skytreasure.SkyTreasureRankRewardInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   
   public class SkyTreasureCoinRewardItem extends Sprite
   {
      
      protected var _CoinRankBg:Image;
      
      protected var _CoinRankName:FilterFrameText;
      
      protected var _CoinRankDesc:FilterFrameText;
      
      private var _hardRewardBox:HBox;
      
      protected var _top:ScaleFrameImage;
      
      private var _data:SkyTreasureRankRewardInfo;
      
      public function SkyTreasureCoinRewardItem()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _CoinRankBg = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.CoinRankBg");
         _CoinRankName = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.CoinRankName");
         _CoinRankDesc = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.CoinRankDesc");
         _CoinRankBg.width = 725;
         _CoinRankBg.height = 66;
         _hardRewardBox = ComponentFactory.Instance.creatCustomObject("skyTreasureCoinRankView.point.advanceRewardBox");
         _top = ComponentFactory.Instance.creatComponentByStylename("skywarlords.RankListCellRankImg");
         addChild(_CoinRankBg);
         addChild(_CoinRankName);
         addChild(_CoinRankDesc);
         addChild(_hardRewardBox);
         addChild(_top);
         _top.y = 14;
         _top.x = 14;
      }
      
      public function set data(param1:SkyTreasureRankRewardInfo) : void
      {
         var _loc6_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         var _loc3_:BaseItemView = null;
         var _loc8_:GoodsInfo = null;
         var _loc7_:int = 0;
         _data = param1;
         var _loc2_:Array = _data.rank.split(",");
         if(_loc2_[0] == 1 || _loc2_[0] == 2 || _loc2_[0] == 3)
         {
            _top.visible = true;
            _top.setFrame(_loc2_[0]);
            _CoinRankName.text = "";
            _CoinRankDesc.text = LanguageMgr.GetTranslation("SkyTreasureCoinRewardFrame.txt2",_loc2_[0],_data.reqGrade);
         }
         else
         {
            _top.visible = false;
            _CoinRankName.text = _loc2_[0] + "-" + _loc2_[1];
            _CoinRankDesc.text = LanguageMgr.GetTranslation("SkyTreasureCoinRewardFrame.txt2",_loc2_[0] + "-" + _loc2_[1],_data.reqGrade);
         }
         if(param1)
         {
            _loc6_ = param1.rewardDesc.split("|");
            _loc4_ = int(_loc6_.length);
            _hardRewardBox.beginChanges();
            _loc7_ = 0;
            while(_loc7_ < _loc4_)
            {
               _loc3_ = ComponentFactory.Instance.creatCustomObject("core.BaseItemView");
               _loc5_ = _loc6_[_loc7_].split(",");
               _loc8_ = new GoodsInfo();
               _loc8_.templateId = _loc5_[0];
               _loc8_.count = _loc5_[1];
               _loc3_.data = _loc8_;
               _hardRewardBox.addChild(_loc3_);
               _loc7_++;
            }
            _hardRewardBox.commitChanges();
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_CoinRankBg);
         _CoinRankBg = null;
         ObjectUtils.disposeObject(_CoinRankName);
         _CoinRankName = null;
         ObjectUtils.disposeObject(_CoinRankDesc);
         _CoinRankDesc = null;
         ObjectUtils.disposeObject(_hardRewardBox);
         _hardRewardBox = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

