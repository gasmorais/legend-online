package yishi.view.frame
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.TextEvent;
   import manager.LanguageMgr;
   import managers.KingContractManager;
   import mvc.module.kingcontract.KingContractInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   
   public class NewKingContractView extends Component implements Disposeable
   {
      
      private var _leftTxt:FilterFrameText;
      
      private var _openTxt:FilterFrameText;
      
      private var _rightTxt:FilterFrameText;
      
      private var _txt:String;
      
      public function NewKingContractView(param1:String = null)
      {
         super();
         _txt = param1;
         initView();
      }
      
      private function initView() : void
      {
         _leftTxt = ComponentFactory.Instance.creatComponentByStylename("kingcontract.openLeftTxt");
         _openTxt = ComponentFactory.Instance.creatComponentByStylename("kingcontract.kingcontractViewTxt");
         _rightTxt = ComponentFactory.Instance.creatComponentByStylename("kingcontract.openRightTxt");
         addChild(_leftTxt);
         addChild(_openTxt);
         addChild(_rightTxt);
         _txt = !_txt ? LanguageMgr.GetTranslation("kingcontract.KingcontractOpen.note1") : _txt;
         _leftTxt.text = _txt + "(";
         _openTxt.htmlText = "<a href =\'event: \'><u>" + LanguageMgr.GetTranslation("mainBar.view.ChoosePayTypeFrame.openVipTxt") + "</u></a>";
         _rightTxt.text = ")";
         _openTxt.mouseEnabled = true;
         _openTxt.addEventListener("link",__onLinkHandler);
         _openTxt.x = _leftTxt.x + _leftTxt.textWidth;
         _rightTxt.x = _openTxt.x + _openTxt.textWidth;
         if(KingContractManager.Instance.model.getInfoById(2).leftTime > 0)
         {
            this.visible = false;
         }
      }
      
      private function __onLinkHandler(param1:TextEvent) : void
      {
         SimpleAlertHelper.instance.data = [__alertBackHandler];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("kingcontract.view.allBuyFrontAlert");
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,false,true);
      }
      
      private function __alertBackHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            FrameControllerManager.instance.openControllerByInfo("kingcontract");
         }
      }
      
      private function get day() : int
      {
         return (KingContractManager.Instance.model.kingContractInfos[2] as KingContractInfo).template.Duration / 1440;
      }
      
      private function get point() : int
      {
         return int(TempleteManager.instance.getConfigInfoByConfigName("All_KingContract").ConfigValue);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override public function dispose() : void
      {
         if(_openTxt)
         {
            _openTxt.removeEventListener("link",__onLinkHandler);
         }
         ObjectUtils.disposeObject(_leftTxt);
         _leftTxt = null;
         ObjectUtils.disposeObject(_openTxt);
         _openTxt = null;
         ObjectUtils.disposeObject(_rightTxt);
         _rightTxt = null;
         super.dispose();
      }
   }
}

