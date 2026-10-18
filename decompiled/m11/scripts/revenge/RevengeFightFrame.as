package revenge
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.revenge.RevengeModel;
   import mvc.module.revenge.RevengeNodeInfo;
   import revenge.view.RevengeFightView;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.CommonDropTempInfo;
   import yishi.datas.templates.RevengeRoadTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.RevengeRoadManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class RevengeFightFrame extends Frame
   {
      
      private var _view:RevengeFightView;
      
      private var _nodeId:int;
      
      private var _cost:int;
      
      private var _bossFightCount:int;
      
      private var _nodeTemp:RevengeRoadTempInfo;
      
      private var isPass:Boolean;
      
      public function RevengeFightFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _view = new RevengeFightView();
         addToContent(_view);
      }
      
      private function get model() : RevengeModel
      {
         return RevengeRoadManager.Ins.model;
      }
      
      private function creatRewards() : void
      {
         var _loc3_:GoodsInfo = null;
         var _loc1_:BaseItemView = null;
         var _loc4_:* = null;
         var _loc2_:Array = null;
         var _loc5_:Array = null;
         if(_nodeTemp == null)
         {
            _nodeTemp = TempleteManager.instance.revengeRoadTempCate.getTempInfo(_nodeId);
         }
         if(_nodeTemp)
         {
            _cost = _nodeTemp.Cost;
            _view._fbtnTxt.text = "-" + _cost;
            _loc2_ = TempleteManager.instance.revengeRoadDropCate.getDropsById(_nodeTemp.FirstDropId);
            _view._fristBox.beginChanges();
            for each(_loc4_ in _loc2_)
            {
               _loc3_ = new GoodsInfo();
               _loc3_.templateId = _loc4_.itemId;
               _loc3_.count = _loc4_.count;
               _loc1_ = ComponentFactory.Instance.creatCustomObject("feedBackFrame.BaseItemView");
               _loc1_.data = _loc3_;
               _view._fristBox.addChild(_loc1_);
            }
            _view._fristBox.commitChanges();
            _loc5_ = TempleteManager.instance.revengeRoadDropCate.getDropsById(_nodeTemp.AttackDropId);
            _loc5_.sortOn("count",0x10 | 2);
            _view._maybeBox.beginChanges();
            for each(_loc4_ in _loc5_)
            {
               _loc3_ = new GoodsInfo();
               _loc3_.templateId = _loc4_.itemId;
               _loc3_.count = _loc4_.count;
               _loc1_ = ComponentFactory.Instance.creatCustomObject("feedBackFrame.BaseItemView");
               _loc1_.data = _loc3_;
               _view._maybeBox.addChild(_loc1_);
            }
            _view._maybeBox.commitChanges();
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _view._ftBtn.addEventListener("click",fightHandler);
         _view._bossBuyBtn.addEventListener("click",buyHandler);
         _view._saodanBtn.addEventListener("click",mopupHandler);
         NotificationManager.instance.addEventListener("REVENGE_ROAD_DATA",dataHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _view._ftBtn.removeEventListener("click",fightHandler);
         _view._bossBuyBtn.removeEventListener("click",buyHandler);
         _view._saodanBtn.removeEventListener("click",mopupHandler);
         NotificationManager.instance.removeEventListener("REVENGE_ROAD_DATA",dataHandler);
      }
      
      private function mopupHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("mopup",15,{
            "nodeId":_nodeId,
            "bossFightCount":_bossFightCount
         });
      }
      
      private function dataHandler(param1:NotificationEvent) : void
      {
         showBossTime();
      }
      
      private function buyHandler(param1:MouseEvent) : void
      {
         var _loc2_:RevengeNodeInfo = model.nodeDic[_nodeId];
         var _loc7_:int = model.bossMaxBuyNum - _loc2_.buyCount;
         var _loc5_:String = LanguageMgr.GetTranslation("revengeroad.main.text4",model.bossMaxBuyPrice,_loc7_);
         SimpleAlertHelper.instance.data = [realBuy];
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc6_:String = LanguageMgr.GetTranslation("public.prompt");
         SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc5_,_loc3_,_loc4_,true,true);
      }
      
      private function realBuy(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            RevengeRoadManager.Ins.sendBuyBoss(_nodeId);
         }
      }
      
      private function fightHandler(param1:MouseEvent) : void
      {
         var _loc4_:String = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc5_:String = null;
         if(_nodeTemp && _nodeTemp.AttackCount > 0)
         {
            if(_bossFightCount <= 0)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("revengeroad.main.text10"));
               return;
            }
         }
         if(model.checkIsNeedBuyAlert(_nodeId))
         {
            _loc4_ = LanguageMgr.GetTranslation("revengeroad.main.text5",model.buyTimePrice,model.MAX_VALUE,model.buyTimeMax - model.buyCount);
            SimpleAlertHelper.instance.data = [confirmBuy];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc5_ = LanguageMgr.GetTranslation("public.prompt");
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc4_,_loc2_,_loc3_,true,true);
            return;
         }
         RevengeRoadManager.Ins.sendAttackNode(_nodeId);
      }
      
      private function confirmBuy(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            RevengeRoadManager.Ins.sendBuyHeart();
         }
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
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_view);
         _view = null;
         super.dispose();
      }
      
      private function showBossTime() : void
      {
         var _loc1_:RevengeNodeInfo = null;
         var _loc2_:String = null;
         if(_nodeTemp == null)
         {
            _nodeTemp = TempleteManager.instance.revengeRoadTempCate.getTempInfo(_nodeId);
         }
         if(_nodeTemp)
         {
            if(_nodeTemp.AttackCount > 0)
            {
               _bossFightCount = _nodeTemp.AttackCount;
               _loc1_ = model.nodeDic[_nodeId];
               if(_loc1_)
               {
                  _bossFightCount = _nodeTemp.AttackCount + _loc1_.buyCount - _loc1_.attackCount;
               }
               _loc2_ = _bossFightCount + "/" + _nodeTemp.AttackCount;
               _view._bossNum.text = LanguageMgr.GetTranslation("revengeroad.main.text9",_loc2_);
               _view._bossBuyBtn.visible = true;
               if(isPass)
               {
                  _view._saodanBtn.enable = _bossFightCount > 0;
               }
               if(_bossFightCount == _nodeTemp.AttackCount)
               {
                  _view._bossBuyBtn.visible = false;
               }
            }
            else
            {
               _view._bossNum.text = "";
               _view._bossBuyBtn.visible = false;
            }
         }
      }
      
      public function show(param1:int) : void
      {
         _nodeId = param1;
         isPass = _nodeId <= model.nodeId;
         _view._fgetFlg.visible = isPass;
         _view._saodanBtn.enable = isPass;
         var _loc2_:int = (param1 - 1) / 10 + 1;
         var _loc3_:int = param1 - (_loc2_ - 1) * 10;
         titleText = _loc2_ + "-" + _loc3_;
         showBossTime();
         creatRewards();
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

