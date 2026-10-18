package monsterexplore
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.ModuleFrameInfo;
   import mvc.module.monsterexplore.MonsterExploreModel;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.ConfigInfoManager;
   import yishi.manager.MonsterExploreManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.base.TokenAmountItem;
   import yishi.view.tips.MessageTipManager;
   
   public class MonsterExploreFastFightFrame extends Frame
   {
      
      private var _mainBack:Bitmap;
      
      private var _descText:FilterFrameText;
      
      private var _countext:FilterFrameText;
      
      private var _fastBtn:IconButton;
      
      private var _pointCost:TokenAmountItem;
      
      private var fastConfigAry:Array;
      
      public function MonsterExploreFastFightFrame()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _mainBack = ComponentFactory.Instance.creatBitmap("asset.MonsterExploreFastFightFrame.mainBack");
         _descText = ComponentFactory.Instance.creatComponentByStylename("MonsterExploreFastFightFrame.descText");
         _countext = ComponentFactory.Instance.creatComponentByStylename("MonsterExploreFastFightFrame.countext");
         _fastBtn = ComponentFactory.Instance.creatComponentByStylename("MonsterExploreFastFightFrame.fastBtn");
         _pointCost = ComponentFactory.Instance.creatComponentByStylename("MonsterExploreFastFightFrame.pointCost");
         addToContent(_mainBack);
         addToContent(_descText);
         addToContent(_countext);
         addToContent(_pointCost);
         addToContent(_fastBtn);
         fastConfigAry = ConfigInfoManager.instance.getMonsterFastFightConfig();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _fastBtn.addEventListener("click",__onFastClickHandler);
         MsgMan.addObserver("USER_INFO_CHANGE",this,__battleUserInfoHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_fastBtn)
         {
            _fastBtn.removeEventListener("click",__onFastClickHandler);
         }
         MsgMan.removeObserver("USER_INFO_CHANGE",this,__battleUserInfoHandler);
      }
      
      private function __battleUserInfoHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __onFastClickHandler(param1:MouseEvent) : void
      {
         if(exploreModel.fastUserCount >= fastConfigAry[0])
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("godarrive.GodArriveFrame.NoLeftCount"));
            return;
         }
         if(exploreModel.exploreMonsterDic.getList().length < 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("MonsterExploreFrame.challengeBoss.noMonsterAlert"));
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("MonsterExploreFastFightFrame.onfast.content",fastConfigAry[2]);
         SimpleAlertHelper.instance.data = [fastConfirmHandler];
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,true,false);
      }
      
      private function fastConfirmHandler(param1:Boolean, param2:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         if(!LogicUtils.judgePointEnoughToShowPay(int(fastConfigAry[2]),false))
         {
            return;
         }
         MonsterExploreManager.instance.sendClientRequest(4);
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = int(fastConfigAry[0]) - exploreModel.fastUserCount;
         var _loc1_:String = fastConfigAry[1];
         if(exploreModel.fastTotalCount > 0)
         {
            _loc1_ += "<font color=\'#ff0000\'>(+" + exploreModel.fastTotalCount + ")</font>";
         }
         _descText.htmlText = LanguageMgr.GetTranslation("MonsterExploreFastFightFrame.descText.text",_loc1_);
         _countext.text = LanguageMgr.GetTranslation("MonsterExploreFastFightFrame.countext.text",_loc2_);
         _pointCost.firstText = fastConfigAry[2];
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function get exploreModel() : MonsterExploreModel
      {
         return MonsterExploreManager.instance.model;
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         this.titleText = LanguageMgr.GetTranslation("MonsterExploreFastFightFrame.title.text");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_mainBack);
         _mainBack = null;
         ObjectUtils.disposeObject(_descText);
         _descText = null;
         ObjectUtils.disposeObject(_countext);
         _countext = null;
         ObjectUtils.disposeObject(_fastBtn);
         _fastBtn = null;
         ObjectUtils.disposeObject(_pointCost);
         _pointCost = null;
         super.dispose();
      }
   }
}

