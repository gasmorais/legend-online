package skytreasure.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import mvc.module.skytreasure.SkyTreasureGradeInfo;
   
   public class SkyTreasureLoRankItmem extends Sprite
   {
      
      protected var _RankItemRank:FilterFrameText;
      
      protected var _RankItemCoin:FilterFrameText;
      
      protected var _RankItemname:FilterFrameText;
      
      protected var _RankItemServer:FilterFrameText;
      
      protected var _libiao7:Bitmap;
      
      protected var _libiao3:Bitmap;
      
      protected var _top:ScaleFrameImage;
      
      private var _data:SkyTreasureGradeInfo;
      
      public function SkyTreasureLoRankItmem()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _RankItemRank = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.RankItemRank");
         _RankItemCoin = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.RankItemCoin");
         _RankItemname = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.RankItemname");
         _RankItemServer = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.RankItemServer");
         _libiao7 = ComponentFactory.Instance.creatBitmap("asset.skyTreasure.xian7");
         _libiao3 = ComponentFactory.Instance.creatBitmap("asset.skyTreasure.xian3");
         _top = ComponentFactory.Instance.creatComponentByStylename("skywarlords.RankListCellRankImg");
         addChild(_RankItemRank);
         addChild(_RankItemCoin);
         addChild(_RankItemname);
         addChild(_RankItemServer);
         addChild(_libiao7);
         addChild(_libiao3);
         addChild(_top);
         _top.y = 9;
         _libiao7.width = 141;
         _libiao3.width = 151;
         _libiao3.y = _libiao7.y = 48;
         _libiao7.x = 151;
      }
      
      public function set data(param1:SkyTreasureGradeInfo) : void
      {
         _data = param1;
         if(_data.rank <= 3)
         {
            _top.visible = true;
            _top.setFrame(_data.rank);
            _RankItemRank.text = "";
         }
         else
         {
            _RankItemRank.text = _data.rank + "";
            _top.visible = false;
         }
         _RankItemCoin.text = _data.grade + "";
         _RankItemServer.text = _data.server;
         _RankItemname.text = _data.name;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_RankItemRank);
         _RankItemRank = null;
         ObjectUtils.disposeObject(_RankItemCoin);
         _RankItemCoin = null;
         ObjectUtils.disposeObject(_RankItemname);
         _RankItemname = null;
         ObjectUtils.disposeObject(_RankItemServer);
         _RankItemServer = null;
         ObjectUtils.disposeObject(_libiao7);
         _libiao7 = null;
         ObjectUtils.disposeObject(_libiao3);
         _libiao3 = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

