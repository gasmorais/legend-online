package goldenDionysia.prizeInfo
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.cccactive.GoldCrazyRewardMsg;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import yishi.manager.GoldenDionysiaManager;
   
   public class GoldenDionysiaBetItem extends Component
   {
      
      private var _betMsg:GoldCrazyRewardMsg;
      
      private var _winInfoTxt:FilterFrameText;
      
      private var _jiachengBmp:Bitmap;
      
      private var _starSign:Bitmap;
      
      private var _displayHeight:int;
      
      public function GoldenDionysiaBetItem()
      {
         super();
         _starSign = ComponentFactory.Instance.creatBitmap("asset.goldendionysia.pointSign");
         _winInfoTxt = ComponentFactory.Instance.creatComponentByStylename("winCountInfo.winBetInfoTxt");
         _jiachengBmp = ComponentFactory.Instance.creatBitmap("asset.goldendionysia.jiachengBmp");
         addChild(_jiachengBmp);
         addChild(_starSign);
         addChild(_winInfoTxt);
         _jiachengBmp.visible = false;
      }
      
      public function set data(param1:GoldCrazyRewardMsg) : void
      {
         _betMsg = param1;
         _winInfoTxt.htmlText = getStr();
         _winInfoTxt.height = _winInfoTxt.textHeight + 6;
         _displayHeight = _winInfoTxt.height;
      }
      
      override public function get displayHeight() : Number
      {
         return _displayHeight;
      }
      
      private function getStr() : String
      {
         var _loc3_:int = 0;
         var _loc1_:String = "";
         var _loc2_:int = int(_betMsg.rewardSite);
         if(_loc2_ == 4)
         {
            _winInfoTxt.setFrame(2);
            _jiachengBmp.visible = GoldenDionysiaManager.instance.isActive;
         }
         var _loc4_:String = _betMsg.rewardPerMaxData > 0 ? LanguageMgr.GetTranslation("goldenDionysia.rewardTxtMax",_betMsg.rewardPerMaxData) : "";
         if(_betMsg.rewardData > 0 && _betMsg.rewardPer > 0)
         {
            _loc3_ = 1;
         }
         else if(_betMsg.rewardPer > 0)
         {
            _loc3_ = 2;
         }
         else if(_betMsg.rewardData > 0)
         {
            _loc3_ = 3;
         }
         switch(_loc2_ - 1)
         {
            case 0:
            case 1:
            case 3:
            case 4:
               if(_loc3_ == 1)
               {
                  _loc1_ = LanguageMgr.GetTranslation("goldenDionysia.rewardTxt" + _loc2_ + _loc3_,_betMsg.rewardPer,_betMsg.rewardData);
               }
               else if(_loc3_ == 2)
               {
                  _loc1_ = LanguageMgr.GetTranslation("goldenDionysia.rewardTxt" + _loc2_ + _loc3_,_betMsg.rewardPer);
               }
               else if(_loc3_ == 3)
               {
                  _loc1_ = LanguageMgr.GetTranslation("goldenDionysia.rewardTxt" + _loc2_ + _loc3_,_betMsg.rewardData);
               }
               break;
            case 2:
               if(_loc3_ == 1)
               {
                  _loc1_ = LanguageMgr.GetTranslation("goldenDionysia.rewardTxt3" + _loc3_,_betMsg.rewardPer,_loc4_,_betMsg.rewardData);
                  break;
               }
               if(_loc3_ == 2)
               {
                  _loc1_ = LanguageMgr.GetTranslation("goldenDionysia.rewardTxt3" + _loc3_,_betMsg.rewardPer,_loc4_);
                  break;
               }
               if(_loc3_ == 3)
               {
                  _loc1_ = LanguageMgr.GetTranslation("goldenDionysia.rewardTxt3" + _loc3_,_betMsg.rewardData);
               }
         }
         return _loc1_;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_winInfoTxt);
         _winInfoTxt = null;
         ObjectUtils.disposeObject(_starSign);
         _starSign = null;
         ObjectUtils.disposeObject(_jiachengBmp);
         _jiachengBmp = null;
         _betMsg = null;
         super.dispose();
      }
   }
}

