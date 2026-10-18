package map.campaign.view.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.battle.TrialInfoMsg;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import map.campaign.data.TrailPropInfo;
   import yishi.comm.PackageOut;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.IconFactory;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BaseItemView;
   
   public class CampaignBuffShopItem extends Sprite implements Disposeable
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _iconBack:Bitmap;
      
      private var _icon:BaseIconView;
      
      private var _countBack:ScaleFrameImage;
      
      private var _count:FilterFrameText;
      
      private var _name:FilterFrameText;
      
      private var _price:FilterFrameText;
      
      private var _iconPrice:BaseItemView;
      
      private var _buyBtn:TextButton;
      
      private var goodsTemplateInfo:GoodsTemplateInfo;
      
      private var _data:TrailPropInfo;
      
      private var _index:int;
      
      public function CampaignBuffShopItem()
      {
         super();
         _index = index;
         initView();
         initEvent();
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("campaign.TrailShop.ItemBack");
         _iconBack = ComponentFactory.Instance.creatBitmap("asset.campaign.Trailmap.TrailBufferBack");
         _icon = ComponentFactory.Instance.creatCustomObject("campaign.TrailShop.ItemIcon");
         _countBack = ComponentFactory.Instance.creatComponentByStylename("campaign.TrailShop.CountBack");
         _count = ComponentFactory.Instance.creatComponentByStylename("campaign.TrailShop.Count");
         _name = ComponentFactory.Instance.creatComponentByStylename("campaign.TrailShop.NameTxt");
         _price = ComponentFactory.Instance.creatComponentByStylename("campaign.TrailShop.Price");
         _iconPrice = ComponentFactory.Instance.creatCustomObject("map.campaign.view.ui.iconPrice");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("campaign.TrailShop.BuyBtn");
         addChild(_back);
         addChild(_iconBack);
         addChild(_icon);
         addChild(_countBack);
         addChild(_count);
         addChild(_name);
         addChild(_price);
         addChild(_iconPrice);
         addChild(_buyBtn);
         _name.text = LanguageMgr.GetTranslation("campaign.TrailShop.BuyCount");
         _buyBtn.text = LanguageMgr.GetTranslation("map.campaign.view.CampaignBuffShopItem.BuyBtnTxt");
      }
      
      public function set data(param1:TrailPropInfo) : void
      {
         _data = param1;
         _icon.tipData = (_data as TrailPropInfo).skillTemp;
         _icon.icon = IconFactory.getTecIconByIcon(_data.skillTemp.Icons);
         _count.text = (_data.maxCount - _data.currentCount).toString();
         _price.text = _data.cost.toString();
         _name.text = _data.skillTemp.TemplateName;
         var _loc2_:GoodsInfo = new GoodsInfo();
         _loc2_.templateId = _data.NeedItemId;
         goodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc2_.templateId);
         _iconPrice.data = _loc2_;
         if(_data.currentCount >= _data.maxCount)
         {
            _countBack.setFrame(2);
            _buyBtn.enable = false;
         }
         else
         {
            _countBack.setFrame(1);
            _buyBtn.enable = true;
         }
      }
      
      public function get data() : TrailPropInfo
      {
         return _data;
      }
      
      private function initEvent() : void
      {
         _buyBtn.addEventListener("click",__buyHandler);
      }
      
      private function removeEvent() : void
      {
         _buyBtn.removeEventListener("click",__buyHandler);
      }
      
      private function __buyHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("map.campaign.view.ui.CampaignBuffShopItem.alert",_data.cost,goodsTemplateInfo.TemplateName,_data.skillTemp.TemplateName);
         SimpleAlertHelper.instance.data = [confirmBack];
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,false,false,2,"SIMPLE_ALERT",0,"",null,"SimpleAlert",_data.cost);
      }
      
      private function confirmBack(param1:Boolean, param2:Boolean) : void
      {
         var _loc4_:PackageOut = null;
         var _loc3_:TrialInfoMsg = null;
         if(param1)
         {
            _loc4_ = new PackageOut(8582);
            _loc3_ = new TrialInfoMsg();
            _loc3_.skillId = _data.id;
            _loc3_.count = 1;
            _loc3_.param1 = 0;
            if(!param2)
            {
               _loc3_.param1 = 1;
            }
            SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_countBack);
         _countBack = null;
         ObjectUtils.disposeObject(_name);
         _name = null;
         ObjectUtils.disposeObject(_count);
         _count = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
      }
   }
}

