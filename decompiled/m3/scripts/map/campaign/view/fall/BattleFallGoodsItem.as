package map.campaign.view.fall
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Sprite;
   import yishi.datas.goods.GoodsInfo;
   import yishi.utils.GoodsHelp;
   import yishi.view.community.BaseItemView;
   
   public class BattleFallGoodsItem extends Sprite implements Disposeable
   {
      
      private var _item:BaseItemView;
      
      private var _bg:ScaleBitmapImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _data:GoodsInfo;
      
      public function BattleFallGoodsItem()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("campaign.FallGoodsItemBg");
         addChild(_bg);
         _item = ComponentFactory.Instance.creatCustomObject("core.fallGoods.BaseItemView");
         addChild(_item);
         _item.x = _item.y = 3;
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("campaign.FallGoodsItemNameTxt");
         addChild(_nameTxt);
      }
      
      public function set data(param1:GoodsInfo) : void
      {
         var _loc2_:String = null;
         _data = param1;
         _item.data = param1;
         if(param1)
         {
            _loc2_ = GoodsHelp.getGoodColorString(param1.templateInfo.Profile);
            _nameTxt.htmlText = "<font color=" + _loc2_ + ">" + param1.templateInfo.TemplateName + "</font>";
            if(_nameTxt.numLines > 1)
            {
               _nameTxt.y = 10;
            }
         }
         else
         {
            _nameTxt.htmlText = "";
         }
      }
      
      public function get data() : GoodsInfo
      {
         return _data;
      }
      
      public function dispose() : void
      {
         if(_item)
         {
            _item.dispose();
         }
         _item = null;
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         if(_nameTxt)
         {
            _nameTxt.dispose();
         }
         _nameTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
      }
   }
}

