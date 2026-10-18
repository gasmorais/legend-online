package skytreasure.rank
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class SkyTreasureHistoryrankItem extends Sprite
   {
      
      protected var _hisRankname:FilterFrameText;
      
      protected var _hisRankserver:FilterFrameText;
      
      protected var _hisRank:FilterFrameText;
      
      private var _vipIcon:ScaleFrameImage;
      
      protected var _libiao7:Bitmap;
      
      protected var _libiao3:Bitmap;
      
      protected var _top:ScaleFrameImage;
      
      private var _data:Object;
      
      public function SkyTreasureHistoryrankItem()
      {
         super();
         initView();
      }
      
      public function set data(param1:Object) : void
      {
         _data = param1;
         _hisRankserver.text = _data.server;
         if(_data.rank <= 3)
         {
            _top.visible = true;
            _top.setFrame(_data.rank);
            _hisRank.text = "";
         }
         else
         {
            _hisRank.text = _data.rank + "";
            _top.visible = false;
         }
         _hisRankname.text = _data.name;
      }
      
      protected function initView() : void
      {
         _hisRankname = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.hisRankname");
         _hisRankserver = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.hisRankserver");
         _hisRank = ComponentFactory.Instance.creatComponentByStylename("ui.SkyTreasure.hisRankserver");
         _hisRank.x = -25;
         _vipIcon = ComponentFactory.Instance.creatComponentByStylename("core.vipIcon");
         _libiao7 = ComponentFactory.Instance.creatBitmap("asset.skyTreasure.xian7");
         _libiao3 = ComponentFactory.Instance.creatBitmap("asset.skyTreasure.xian3");
         _top = ComponentFactory.Instance.creatComponentByStylename("skywarlords.RankListCellRankImg");
         _top.x = 24;
         addChild(_hisRankname);
         addChild(_hisRankserver);
         addChild(_hisRank);
         addChild(_top);
         addChild(_libiao7);
         addChild(_libiao3);
         _libiao7.width = 261;
         _libiao3.width = 251;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_hisRankname);
         _hisRankname = null;
         ObjectUtils.disposeObject(_hisRankserver);
         _hisRankserver = null;
         ObjectUtils.disposeObject(_hisRank);
         _hisRank = null;
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

