package goldenDionysia.prizeInfo
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.cccactive.GoldCrazyMsg;
   import com.road.yishi.proto.cccactive.GoldCrazyRewardMsg;
   import manager.LanguageMgr;
   import yishi.manager.GoldenDionysiaManager;
   
   public class GoldenDionysiaItem extends Component
   {
      
      private var _prizeType:int = -1;
      
      private var _prizeTypeTitleBmp:ScaleFrameImage;
      
      private var _prizeBg:ScaleBitmapImage;
      
      private var _vBox:VBox;
      
      private var _scrol1Panel:ScrollPanel;
      
      private var _winnerCountTxt:FilterFrameText;
      
      private var _winCountInfoTxt:FilterFrameText;
      
      public function GoldenDionysiaItem(param1:uint)
      {
         super();
         _prizeType = param1;
         initView();
      }
      
      private function initView() : void
      {
         _prizeTypeTitleBmp = ComponentFactory.Instance.creatComponentByStylename("goldenDionysiaRank.prizeImage");
         _prizeTypeTitleBmp.setFrame(_prizeType);
         _prizeBg = ComponentFactory.Instance.creatComponentByStylename("goldendionysia.bg");
         _winnerCountTxt = ComponentFactory.Instance.creatComponentByStylename("winnerCountInfo.winCountTxt");
         _winCountInfoTxt = ComponentFactory.Instance.creatComponentByStylename("winCountInfo.winCountInfoTxt");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("goldenDionysiaFrame.betInfoVBox");
         _scrol1Panel = ComponentFactory.Instance.creatComponentByStylename("agoldenDionysia.goldenDionysiaItemScrol1");
         addChild(_prizeTypeTitleBmp);
         addChild(_prizeBg);
         addChild(_winnerCountTxt);
         addChild(_winCountInfoTxt);
         addChild(_scrol1Panel);
         _scrol1Panel.setView(_vBox);
         if(_prizeType == 4)
         {
            _prizeTypeTitleBmp.x = -17;
            _prizeBg.scaleX = -1;
            _prizeBg.x = 180;
            _winCountInfoTxt.width = 117;
            _winCountInfoTxt.x = 65;
            _winnerCountTxt.x = 58;
         }
         if(_prizeType == 5)
         {
            _prizeTypeTitleBmp.x = -17;
            _prizeBg.scaleX = -1;
            _prizeBg.x = 180;
            _winCountInfoTxt.width = 125;
            _winCountInfoTxt.x = 58;
            _winnerCountTxt.x = 60;
            _scrol1Panel.y = 45;
         }
      }
      
      public function set data(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc3_:GoldenDionysiaBetItem = null;
         var _loc5_:GoldCrazyMsg = null;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         if(!param1)
         {
            return;
         }
         _vBox.disposeAllChildren();
         param1.sortOn(["rewardSite"],[16]);
         _vBox.beginChanges();
         var _loc2_:GoldCrazyRewardMsg = param1[0];
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = ComponentFactory.Instance.creatCustomObject("goldenDionysia.prizeInfo.GoldenDionysiaBetItem");
            _loc3_.data = param1[_loc4_];
            _vBox.addChild(_loc3_);
            _loc4_++;
         }
         _vBox.commitChanges();
         _scrol1Panel.invalidateViewport();
         _winCountInfoTxt.text = LanguageMgr.GetTranslation("GoldenDionysiaItem.needNum",_loc2_.needNum1,_loc2_.needNum2);
         if(_prizeType == 4)
         {
            _loc5_ = GoldenDionysiaManager.instance.goldenMsg;
            if(_loc5_.state == GoldenDionysiaManager.STATE1)
            {
               if(_loc5_.luckMaxCount >= _loc5_.activeLuckMaxCount)
               {
                  _winnerCountTxt.text = LanguageMgr.GetTranslation("GoldenDionysiaItem.winCountTxt1",_loc5_.luckMaxCount);
               }
               else
               {
                  _winnerCountTxt.htmlText = LanguageMgr.GetTranslation("GoldenDionysiaItem.winCountTxt8",_loc5_.luckMaxCount,_loc5_.activeLuckMaxCount - _loc5_.luckMaxCount);
               }
            }
            if(_loc5_.state == GoldenDionysiaManager.STATE2)
            {
               if(GoldenDionysiaManager.instance.isActive)
               {
                  if(_loc5_.luckMaxCount >= _loc5_.activeLuckMaxCount)
                  {
                     _loc7_ = _loc5_.luckMaxCount - _loc5_.currentLuckCount;
                     _loc6_ = int(_loc5_.luckMaxCount);
                  }
                  else
                  {
                     _loc7_ = _loc5_.activeLuckMaxCount - _loc5_.currentLuckCount;
                     _loc6_ = int(_loc5_.activeLuckMaxCount);
                  }
               }
               else
               {
                  _loc7_ = _loc5_.luckMaxCount - _loc5_.currentLuckCount;
                  _loc6_ = int(_loc5_.luckMaxCount);
               }
               _winnerCountTxt.htmlText = LanguageMgr.GetTranslation("GoldenDionysiaItem.winCountTxt2",_loc7_,_loc6_);
            }
            _winCountInfoTxt.text = LanguageMgr.GetTranslation("GoldenDionysiaItem.needNum4",_loc2_.needNum1,_loc2_.needNum2);
            _winCountInfoTxt.y = 12;
         }
         if(_prizeType == 5)
         {
            _winnerCountTxt.text = LanguageMgr.GetTranslation("GoldenDionysiaItem.winCountTxt3");
            _winCountInfoTxt.text = LanguageMgr.GetTranslation("GoldenDionysiaItem.winCountTxt4");
            _winCountInfoTxt.y = 12;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_prizeTypeTitleBmp);
         _prizeTypeTitleBmp = null;
         ObjectUtils.disposeObject(_prizeBg);
         _prizeBg = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_winnerCountTxt);
         _winnerCountTxt = null;
         ObjectUtils.disposeObject(_winCountInfoTxt);
         _winCountInfoTxt = null;
         ObjectUtils.disposeObject(_scrol1Panel);
         _scrol1Panel = null;
         super.dispose();
      }
   }
}

