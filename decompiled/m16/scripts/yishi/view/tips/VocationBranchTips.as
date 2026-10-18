package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   
   public class VocationBranchTips extends BaseTip
   {
      
      private var _totalBox:VBox;
      
      private var _line:Bitmap;
      
      private var _branchTitleTxt:FilterFrameText;
      
      private var _branchDescTxt:FilterFrameText;
      
      private var _branchNeedTxt:FilterFrameText;
      
      private var _branchNeedValueTxt1:FilterFrameText;
      
      public function VocationBranchTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _totalBox = ComponentFactory.Instance.creatComponentByStylename("changejob.branchTotalBox");
         _branchTitleTxt = ComponentFactory.Instance.creatComponentByStylename("changejob.branchTitleTxt");
         _branchDescTxt = ComponentFactory.Instance.creatComponentByStylename("changejob.branchDescTxt");
         _branchNeedTxt = ComponentFactory.Instance.creatComponentByStylename("changejob.branchNeedTxt");
         _branchNeedValueTxt1 = ComponentFactory.Instance.creatComponentByStylename("changejob.branchNeedValueTxt");
         _line = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _bg.width = 270;
         addChild(_totalBox);
      }
      
      override protected function updateTransform() : void
      {
         clean();
         _branchTitleTxt.text = LanguageMgr.GetTranslation("changeJob.branchName" + tipData);
         _branchDescTxt.height = 120;
         _branchDescTxt.text = LanguageMgr.GetTranslation("changeJob.branchDesc" + tipData);
         _branchDescTxt.height = _branchDescTxt.textHeight + 5;
         _branchNeedTxt.text = LanguageMgr.GetTranslation("changeJob.needTxt");
         _branchNeedValueTxt1.height = 120;
         _branchNeedValueTxt1.htmlText = getConditionString();
         _branchNeedValueTxt1.height = _branchNeedValueTxt1.textHeight + 5;
         _bg.width = _branchDescTxt.width + 20;
         _totalBox.addChild(_branchTitleTxt);
         _totalBox.addChild(_branchDescTxt);
         _bg.height = _totalBox.height + 20;
      }
      
      private function getConditionString() : String
      {
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:String = "Job" + (tipData as String).charAt(0) + "_Branch" + (tipData as String).charAt(1);
         var _loc6_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName(_loc8_);
         if(!_loc6_)
         {
            return "";
         }
         var _loc3_:String = _loc6_.ConfigValue;
         var _loc2_:Array = _loc3_.split(",");
         var _loc5_:Array = FrameControllerManager.instance.tattooController.tattooModel.calculateAddProperty();
         var _loc1_:String = "";
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc7_ = int(_loc2_[_loc4_]);
            if(_loc7_ > 0)
            {
               if(_loc5_[_loc4_] >= _loc2_[_loc4_])
               {
                  _loc1_ += "<font color=\'#55c03b\'>";
               }
               else
               {
                  _loc1_ += "<font color=\'#7b7b7b\'>";
               }
               _loc1_ += LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip0" + (_loc4_ + 1)) + "+" + _loc2_[_loc4_];
               _loc1_ += "</font>\n";
            }
            _loc4_++;
         }
         return _loc1_.substr(0,_loc1_.length - 1);
      }
      
      private function clean() : void
      {
         _totalBox.removeAllChild();
      }
      
      override public function dispose() : void
      {
         if(_totalBox)
         {
            _totalBox.dispose();
         }
         _totalBox = null;
         if(_line)
         {
            ObjectUtils.disposeObject(_line);
         }
         _line = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
   }
}

