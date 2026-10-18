package war2023.view
{
   import manager.LanguageMgr;
   import mvc.module.war2023.info.SecretwarPlayInfo;
   import war2023.ui.SecretwarNodePlayInfoUI;
   
   public class SecretwarNodePlayInfoView extends SecretwarNodePlayInfoUI
   {
      
      private var _restStr:String;
      
      private var _fightStr:String;
      
      private var _defandStr:String;
      
      private var _occupyStr:String;
      
      private var _jobArr:Array = [];
      
      public function SecretwarNodePlayInfoView()
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         super();
         _restStr = LanguageMgr.GetTranslation("secretwar.playerState.rest");
         _fightStr = LanguageMgr.GetTranslation("secretwar.playerState.fight");
         _defandStr = LanguageMgr.GetTranslation("secretwar.playerState.defand");
         _occupyStr = LanguageMgr.GetTranslation("secretwar.playerState6.occupy");
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _loc2_ = _loc1_ + 1;
            _jobArr.push(LanguageMgr.GetTranslation("yishi.datas.consant.JobType.JobName" + _loc2_));
            _loc1_++;
         }
      }
      
      public function updateBlue(param1:SecretwarPlayInfo) : void
      {
         if(!param1)
         {
            _nodePlayTRNameTxt.text = "";
            _nodePlayTRStateTxt.text = "";
            return;
         }
         _nodePlayTRNameTxt.htmlText = param1.nickName + "<font color=\'#ffd52d\'>  " + _jobArr[param1.job - 1] + "</font>";
         switch(int(param1.state))
         {
            case 0:
               _nodePlayTRStateTxt.text = _restStr;
               _nodePlayTRStateTxt.setFrame(3);
               break;
            case 4:
               _nodePlayTRStateTxt.text = _fightStr;
               _nodePlayTRStateTxt.setFrame(2);
               break;
            case 5:
               _nodePlayTRStateTxt.text = _defandStr;
               _nodePlayTRStateTxt.setFrame(2);
               break;
            case 6:
               _nodePlayTRStateTxt.text = _occupyStr + "(" + param1.cdTime + "s)";
               _nodePlayTRStateTxt.setFrame(1);
         }
      }
      
      public function updateRed(param1:SecretwarPlayInfo) : void
      {
         if(!param1)
         {
            _nodePlayTLNameTxt.text = "";
            _nodePlayTLStateTxt.text = "";
            return;
         }
         _nodePlayTLNameTxt.htmlText = param1.nickName + "<font color=\'#ffd52d\'>  " + _jobArr[param1.job - 1] + "</font>";
         switch(int(param1.state))
         {
            case 0:
               _nodePlayTLStateTxt.text = _restStr;
               _nodePlayTLStateTxt.setFrame(3);
               break;
            case 4:
               _nodePlayTLStateTxt.text = _fightStr;
               _nodePlayTLStateTxt.setFrame(2);
               break;
            case 5:
               _nodePlayTLStateTxt.text = _defandStr;
               _nodePlayTLStateTxt.setFrame(2);
               break;
            case 6:
               _nodePlayTLStateTxt.text = _occupyStr + "(" + param1.cdTime + "s)";
               _nodePlayTLStateTxt.setFrame(1);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _jobArr = null;
      }
   }
}

