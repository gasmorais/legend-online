package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import fund.FundItem;
   import manager.LanguageMgr;
   import managers.FundManager;
   import mvc.module.fund.ActiveParmaInfo;
   import mvc.module.fund.GItemInfo;
   import mvc.module.fund.GetItemInfo;
   
   public class FundBuyItemTip extends BaseTip
   {
      
      private var _vbox:VBox;
      
      private var _consumeHbox:HBox;
      
      private var _consumeTxt:FilterFrameText;
      
      private var _consumeTxt2:FilterFrameText;
      
      private var _splitLine:ScaleBitmapImage;
      
      private var _list:Array;
      
      private var _isNewbie:Boolean = false;
      
      public function FundBuyItemTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _list = [];
         _vbox = ComponentFactory.Instance.creatComponentByStylename("fund.fundBuyItemTipVbox");
         _consumeHbox = ComponentFactory.Instance.creatComponentByStylename("fund.consumeHBox");
         _consumeTxt = ComponentFactory.Instance.creatComponentByStylename("fund.consumeTxt");
         _splitLine = ComponentFactory.Instance.creatComponentByStylename("tips.TaskTraceLine");
         _splitLine.width = 220;
         addChild(_vbox);
         _vbox.addChild(_consumeHbox);
         _consumeTxt2 = ComponentFactory.Instance.creatComponentByStylename("fund.consumeTxt");
      }
      
      override protected function updateTransform() : void
      {
         var _loc11_:FundItem = null;
         var _loc8_:FundItem = null;
         var _loc6_:int = 0;
         var _loc4_:HBox = null;
         var _loc2_:FilterFrameText = null;
         var _loc13_:GetItemInfo = null;
         var _loc10_:int = 0;
         var _loc5_:GItemInfo = null;
         var _loc7_:int = 0;
         var _loc1_:FundItem = null;
         _isNewbie = FundManager.instance.isNewbie;
         uint();
         var _loc12_:ActiveParmaInfo = tipData as ActiveParmaInfo;
         var _loc3_:int = _isNewbie ? 1 : 0;
         _consumeTxt.text = LanguageMgr.GetTranslation("fund.fundBuyItemTip.consumeTxt" + _loc3_);
         _consumeHbox.addChild(_consumeTxt);
         if(_loc12_.costDiamond > 0)
         {
            _loc11_ = new FundItem();
            _loc11_.show({
               "type":"0",
               "num":_loc12_.costDiamond,
               "itemTempleteId":"-400"
            });
            _consumeHbox.addChild(_loc11_);
            _list.push(_loc11_);
         }
         if(_loc12_.costContract > 0)
         {
            _loc8_ = new FundItem();
            _loc8_.show({
               "type":"0",
               "num":_loc12_.costContract,
               "itemTempleteId":"2125044"
            });
            _consumeHbox.addChild(_loc8_);
            _list.push(_loc8_);
         }
         _consumeTxt2.text = LanguageMgr.GetTranslation("fund.fundBuyItemTip.consumeTxt2");
         _consumeHbox.addChild(_consumeTxt2);
         _vbox.addChild(_splitLine);
         var _loc9_:int = int(_loc12_.harvestCount);
         _loc6_ = 0;
         while(_loc6_ < _loc9_)
         {
            _loc4_ = new HBox();
            _loc4_.spacing = 5;
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("fund.dayTxt");
            _loc13_ = _loc12_.getInfos[_loc6_];
            _loc10_ = int(_loc13_.itemInfos.length);
            if(_isNewbie)
            {
               _loc2_.text = LanguageMgr.GetTranslation("buildings.casern.view.RecruitPawnCell.command06",_loc13_.interval);
            }
            else
            {
               _loc2_.text = LanguageMgr.GetTranslation("fund.fundBuyItemTip.dayTxt" + _loc6_);
            }
            _loc4_.addChild(_loc2_);
            _loc7_ = 0;
            while(_loc7_ < _loc10_)
            {
               _loc4_.x = 10;
               _loc5_ = _loc13_.itemInfos[_loc7_];
               _loc1_ = new FundItem();
               _loc1_.show({
                  "type":"0",
                  "num":_loc5_.count,
                  "itemTempleteId":_loc5_.templateId
               });
               _list.push(_loc1_);
               _loc4_.addChild(_loc1_);
               _loc7_++;
            }
            _list.push(_loc4_);
            _vbox.addChild(_loc4_);
            _loc6_++;
         }
         _vbox.refreshChildPos();
         _bg.width = _vbox.width + 20;
         _bg.height = _vbox.height + _vbox.y + 4;
      }
      
      private function uint() : void
      {
         var _loc1_:Component = null;
         var _loc2_:int = 0;
         if(_consumeTxt2)
         {
            ObjectUtils.disposeObject(_consumeTxt2);
         }
         _loc2_ = _list.length - 1;
         while(_loc2_ >= 0)
         {
            _loc1_ = _list.pop();
            if(_loc1_)
            {
               _loc1_.dispose();
               if(_loc1_.parent)
               {
                  _loc1_.parent.removeChild(_loc1_);
               }
            }
            _loc2_--;
         }
      }
      
      override public function dispose() : void
      {
         uint();
         if(_consumeTxt)
         {
            ObjectUtils.disposeObject(_consumeTxt);
         }
         _consumeTxt = null;
         if(_consumeTxt2)
         {
            ObjectUtils.disposeObject(_consumeTxt2);
         }
         _consumeTxt2 = null;
         if(_splitLine)
         {
            ObjectUtils.disposeObject(_splitLine);
         }
         _splitLine = null;
         if(_consumeHbox)
         {
            ObjectUtils.disposeAllChildren(_consumeHbox);
         }
         _consumeHbox = null;
      }
   }
}

