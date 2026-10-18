package vip
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.vip.VIPModel;
   import yishi.manager.FrameControllerManager;
   
   public class OpenVipItem extends Sprite implements Disposeable
   {
      
      private var _index:int;
      
      private var _pointTxt:FilterFrameText;
      
      private var _bg:Bitmap;
      
      private var _iconBg:Bitmap;
      
      private var _icon:Bitmap;
      
      private var _pointImg:Bitmap;
      
      private var _name:GradientText;
      
      private var _mask:Sprite;
      
      private var _rebate:Bitmap;
      
      private var _overBg:Bitmap;
      
      public function OpenVipItem()
      {
         super();
      }
      
      private function initView() : void
      {
         _iconBg = ComponentFactory.Instance.creatBitmap("asset.vip.OpenVipItemIconBg");
         _pointImg = ComponentFactory.Instance.creatBitmap("asset.core.SmallPointImg");
         _pointTxt = ComponentFactory.Instance.creatComponentByStylename("vip.needPointTxt");
         if(_index == 6)
         {
            _icon = ComponentFactory.Instance.creatBitmap("asset.vip.OpenVipItemIcon06");
            _name = ComponentFactory.Instance.creatComponentByStylename("vip.VipOpenItemNane06");
            _name.text = LanguageMgr.GetTranslation("vip.view.OpenVipItem.ItemName06");
            _pointTxt.text = model.six_MonthPoint.toString();
            _bg = ComponentFactory.Instance.creatBitmap("asset.vip.OpenVipItemHalfBg");
            _rebate = ComponentFactory.Instance.creatBitmap("asset.vip.OpenViprebatetBg");
            _overBg = ComponentFactory.Instance.creatBitmap("asset.vip.OpenVipItemOverHalf");
            _pointTxt.x = 72;
            _pointImg.x = 125;
         }
         else if(_index == 3)
         {
            _icon = ComponentFactory.Instance.creatBitmap("asset.vip.OpenVipItemIcon03");
            _name = ComponentFactory.Instance.creatComponentByStylename("vip.VipOpenItemNane03");
            _name.text = LanguageMgr.GetTranslation("vip.view.OpenVipItem.ItemName03");
            _pointTxt.text = model.three_MonthPoint.toString();
            _bg = ComponentFactory.Instance.creatBitmap("asset.vip.OpenVipItemThrOneBg");
            _rebate = ComponentFactory.Instance.creatBitmap("asset.vip.OpenViprebatetBg");
            _overBg = ComponentFactory.Instance.creatBitmap("asset.vip.OpenVipItemOverThrOne");
            _rebate.visible = false;
            _pointTxt.x = 66;
            _pointImg.x = 120;
         }
         else
         {
            _icon = ComponentFactory.Instance.creatBitmap("asset.vip.OpenVipItemIcon01");
            _name = ComponentFactory.Instance.creatComponentByStylename("vip.VipOpenItemNane01");
            _name.text = LanguageMgr.GetTranslation("vip.view.OpenVipItem.ItemName01");
            _pointTxt.text = model.one_MonthPoint.toString();
            _bg = ComponentFactory.Instance.creatBitmap("asset.vip.OpenVipItemThrOneBg");
            _rebate = ComponentFactory.Instance.creatBitmap("asset.vip.OpenViprebatetBg");
            _overBg = ComponentFactory.Instance.creatBitmap("asset.vip.OpenVipItemOverThrOne");
            _rebate.visible = false;
            _pointTxt.x = 66;
            _pointImg.x = 120;
         }
         _mask = new Sprite();
         _mask.graphics.beginFill(0);
         _mask.graphics.drawRect(0,0,_bg.width,_bg.height);
         _mask.graphics.endFill();
         addChild(_bg);
         addChild(_iconBg);
         addChild(_icon);
         addChild(_name);
         addChild(_pointImg);
         addChild(_pointTxt);
         addChild(_overBg);
         addChild(_rebate);
         addChild(_mask);
         _pointImg.y = _pointTxt.y;
         _mask.alpha = 0.5;
      }
      
      private function initEvent() : void
      {
         addEventListener("mouseOver",__overHandler);
         addEventListener("mouseOut",__outHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOver",__overHandler);
         removeEventListener("mouseOut",__outHandler);
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         _mask.alpha = 0;
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         _mask.alpha = 0.5;
      }
      
      public function set isSelect(param1:Boolean) : void
      {
         if(param1)
         {
            _mask.visible = false;
            _overBg.visible = true;
         }
         else
         {
            _mask.visible = true;
            _overBg.visible = false;
         }
      }
      
      public function get point() : int
      {
         return int(_pointTxt.text);
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function set index(param1:int) : void
      {
         if(param1 == 0)
         {
            _index = 6;
         }
         else if(param1 == 1)
         {
            _index = 3;
         }
         else
         {
            _index = 1;
         }
         initView();
         initEvent();
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function get model() : VIPModel
      {
         return FrameControllerManager.instance.vipController.model;
      }
   }
}

