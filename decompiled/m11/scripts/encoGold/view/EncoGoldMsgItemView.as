package encoGold.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import managers.EncoGoldManager;
   import mvc.module.encoGold.EncoGoldItemInfo;
   import mvc.module.encoGold.EncoGoldModel;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   
   public class EncoGoldMsgItemView extends Sprite implements Disposeable
   {
      
      private var _choseBit:Bitmap;
      
      private var _dayTxt:FilterFrameText;
      
      private var _goldBit:Bitmap;
      
      private var _goldTxt:FilterFrameText;
      
      private var _getTxt:FilterFrameText;
      
      private var _tipsComt:Component;
      
      private var _tipsTxt:FilterFrameText;
      
      public function EncoGoldMsgItemView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _choseBit = ComponentFactory.Instance.creatBitmap("asset.encoGold.itemChoseBack");
         _dayTxt = ComponentFactory.Instance.creatComponentByStylename("encoGold.msgDayTxt");
         _goldBit = ComponentFactory.Instance.creatBitmap("asset.encoGold.goldIcon");
         _goldTxt = ComponentFactory.Instance.creatComponentByStylename("encoGold.msgGoldTxt");
         _getTxt = ComponentFactory.Instance.creatComponentByStylename("encoGold.msgGetTxt");
         _tipsComt = ComponentFactory.Instance.creatComponentByStylename("encoGold.tipsSprite");
         _tipsTxt = ComponentFactory.Instance.creatComponentByStylename("encoGold.tipsTxt");
         addChild(_choseBit);
         addChild(_dayTxt);
         addChild(_goldBit);
         addChild(_goldTxt);
         addChild(_getTxt);
         addChild(_tipsComt);
         _tipsComt.addChild(_tipsTxt);
         _getTxt.text = LanguageMgr.GetTranslation("encoGold.encoGoldTips06");
         _choseBit.visible = false;
         _choseBit.height = 44;
      }
      
      public function set info(param1:EncoGoldItemInfo) : void
      {
         _dayTxt.text = LanguageMgr.GetTranslation("encoGold.encoGoldTips05",param1.dayStr);
         _goldTxt.text = String(param1.consumPoint);
         var _loc4_:EncoGoldItemInfo = model.dayMsgList[model.currentDay - 1];
         _getTxt.y = 29;
         _choseBit.height = 44;
         if(_loc4_ && _loc4_.dayStr == param1.dayStr)
         {
            _choseBit.visible = true;
         }
         _tipsComt.visible = true;
         var _loc5_:String = "";
         var _loc2_:String = "";
         if(param1.type == 1)
         {
            _loc5_ = LanguageMgr.GetTranslation("encoGold.encoGoldTips06");
            _tipsTxt.htmlText = LanguageMgr.GetTranslation("encoGold.encoGoldTips08");
            _loc2_ = LanguageMgr.GetTranslation("encoGold.encoGoldTips10",param1.takePoint);
         }
         else
         {
            _loc5_ = LanguageMgr.GetTranslation("encoGold.encoGoldTips07");
            _tipsTxt.htmlText = LanguageMgr.GetTranslation("encoGold.encoGoldTips09");
            _loc2_ = LanguageMgr.GetTranslation("encoGold.encoGoldTips11",param1.takePoint);
         }
         var _loc3_:int = getDayType(param1.dayStr);
         if(_loc3_ == 1)
         {
            if(!param1.isTaked)
            {
               _loc5_ = LanguageMgr.GetTranslation("encoGold.encoGoldTips12");
               _tipsComt.visible = false;
            }
         }
         else if(_loc3_ == 2)
         {
            if(!param1.isTaked)
            {
               if(param1.type == 1)
               {
                  _loc5_ = LanguageMgr.GetTranslation("encoGold.encoGoldTips13");
               }
               else
               {
                  _loc5_ = LanguageMgr.GetTranslation("encoGold.encoGoldTips16");
               }
               _tipsComt.visible = false;
            }
         }
         else if(!param1.isTaked)
         {
            _loc5_ = LanguageMgr.GetTranslation("encoGold.encoGoldTips14");
            _tipsComt.visible = _goldTxt.visible = _goldBit.visible = false;
            _getTxt.y = 14;
            _choseBit.height = 30;
         }
         _getTxt.htmlText = _loc5_;
         _tipsComt.tipData = _loc2_;
      }
      
      private function getDayType(param1:String) : int
      {
         var _loc2_:Date = PlayerManager.instance.currentPlayerModel.sysCurtime;
         var _loc3_:String = _loc2_.month + 1 < 10 ? "0" + (_loc2_.month + 1) : String(_loc2_.month + 1);
         var _loc8_:String = _loc2_.date < 10 ? "0" + _loc2_.date : String(_loc2_.date);
         var _loc4_:String = _loc2_.fullYear + "-" + _loc3_ + "-" + _loc8_;
         var _loc6_:Number = Number(DateFormatter.parse(_loc4_,"YYYY-MM-DD").time);
         var _loc5_:Number = Number(DateFormatter.parse(param1,"YYYY-MM-DD").time);
         var _loc7_:int = 0;
         if(_loc6_ > _loc5_)
         {
            _loc7_ = 1;
         }
         else if(_loc6_ == _loc5_)
         {
            _loc7_ = 2;
         }
         else
         {
            _loc7_ = 3;
         }
         return _loc7_;
      }
      
      private function get model() : EncoGoldModel
      {
         return EncoGoldManager.instance.model;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_choseBit);
         _choseBit = null;
         ObjectUtils.disposeObject(_dayTxt);
         _dayTxt = null;
         ObjectUtils.disposeObject(_goldBit);
         _goldBit = null;
         ObjectUtils.disposeObject(_goldTxt);
         _goldTxt = null;
         ObjectUtils.disposeObject(_getTxt);
         _getTxt = null;
         ObjectUtils.disposeObject(_tipsTxt);
         _tipsTxt = null;
         ObjectUtils.disposeObject(_tipsComt);
         _tipsComt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

