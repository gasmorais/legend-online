package auction.view.buy
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class HotSearchItem extends Sprite implements Disposeable
   {
      
      private var _back:Bitmap;
      
      private var _iconView:BaseIconView;
      
      private var _goodsName:FilterFrameText;
      
      private var _sp:Sprite;
      
      public function HotSearchItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.auction.hotSearchBack");
         _iconView = ComponentFactory.Instance.creatComponentByStylename("auction.hotSearchItem.IconView");
         _goodsName = ComponentFactory.Instance.creatComponentByStylename("auction.hotSearchItem.name");
         _sp = new Sprite();
         buttonMode = true;
         if(_back)
         {
            addChild(_back);
         }
         if(_iconView)
         {
            addChild(_iconView);
         }
         if(_goodsName)
         {
            addChild(_goodsName);
         }
         if(_sp)
         {
            addChild(_sp);
         }
      }
      
      public function get displayWidth() : int
      {
         return width - (_goodsName.width - _goodsName.textWidth) + 20;
      }
      
      public function set index(param1:int) : void
      {
         switch(param1)
         {
            case 0:
               _iconView.icon = IconFactory.getGoodsIconByTID(2129400);
               _goodsName.text = LanguageMgr.GetTranslation("auction.view.buy.HotSearchItem.goodsName0");
               break;
            case 1:
               _iconView.icon = IconFactory.getGoodsIconByTID(2129003);
               _goodsName.text = LanguageMgr.GetTranslation("auction.view.buy.HotSearchItem.goodsName1");
               break;
            case 2:
               _iconView.icon = IconFactory.getGoodsIconByTID(208014);
               _goodsName.text = LanguageMgr.GetTranslation("auction.view.buy.HotSearchItem.goodsName2");
               break;
            case 3:
               _iconView.icon = IconFactory.getGoodsIconByTID(208012);
               _goodsName.text = LanguageMgr.GetTranslation("auction.view.buy.HotSearchItem.goodsName3");
               break;
            case 4:
               _iconView.icon = IconFactory.getGoodsIconByTID(2130005);
               _goodsName.text = LanguageMgr.GetTranslation("auction.view.buy.HotSearchItem.goodsName4");
               break;
            case 5:
               _iconView.icon = IconFactory.getGoodsIconByTID(2127003);
               _goodsName.text = LanguageMgr.GetTranslation("auction.view.buy.HotSearchItem.goodsName5");
         }
         setHitArea();
      }
      
      private function setHitArea() : void
      {
         _sp.graphics.clear();
         _sp.graphics.beginFill(0,0);
         _sp.graphics.drawRect(0,0,_goodsName.textWidth,_goodsName.height);
         _sp.x = _goodsName.x;
         _sp.y = _goodsName.y;
      }
      
      private function initEvent() : void
      {
         addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__clickHandler);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         NotificationManager.instance.dispatchEvent(new NotificationEvent("AUCTION_HOT_SEARCH",_goodsName.text));
      }
      
      public function dispose() : void
      {
         removeEvent();
         _sp = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_iconView);
         _iconView = null;
         ObjectUtils.disposeObject(_goodsName);
         _goodsName = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

