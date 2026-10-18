package christmas
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.christmas.SnowyMistMapMsg;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.christmas.ChristmasModel;
   import mvc.module.stararea.StarareaManager;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.templates.ChristmasActivitiesTempInfo;
   import yishi.manager.ChristmasManager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.MessageTipManager;
   
   public class ChristmasSnowymistMapItem extends Sprite implements Disposeable
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _icon:ScaleFrameImage;
      
      private var _txt:FilterFrameText;
      
      private var _index:int;
      
      private var _mask:Bitmap;
      
      public function ChristmasSnowymistMapItem(param1:int)
      {
         super();
         _index = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ChristmasSnowymistMapItem.bg");
         _icon = ComponentFactory.Instance.creatComponentByStylename("ChristmasSnowymistMapItem.icon");
         _txt = ComponentFactory.Instance.creatComponentByStylename("ChristmasSnowymistMapItem.txt");
         _mask = ComponentFactory.Instance.creatBitmap("asset.ChristmasSnowymistMapItem.mask");
         addChild(_bg);
         addChild(_icon);
         addChild(_txt);
         addChild(_mask);
         _mask.visible = false;
         _bg.setFrame(1);
         _icon.visible = false;
         _icon.mouseChildren = _icon.mouseEnabled = false;
         _icon.setFrame(1);
         this.buttonMode = true;
      }
      
      private function addEvent() : void
      {
         this.addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("click",__clickHandler);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(!data)
         {
            return;
         }
         switch(itemState)
         {
            case 0:
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChristmasSnowymistMapItem.message.txt1"));
               break;
            case 1:
               _loc2_ = LanguageMgr.GetTranslation("active.expback.frame.selectbtntxt");
               _loc3_ = LanguageMgr.GetTranslation("ChristmasSnowymistMapItem.message.txt2",actionNum);
               SharedManagerHelper.ins.needAlert("ChristmasSnowymistFrame_clickHandler",sendClick,_loc2_,_loc3_);
               break;
            case 2:
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChristmasSnowymistMapItem.message.txt3"));
               break;
            case 3:
               if(eventInfo)
               {
                  if(eventInfo.SonType == 2)
                  {
                     StarareaManager.instance.model.gameRoadId = -1;
                     StarareaManager.instance.startMiniGame(eventInfo.Para1);
                     model.selecedNodeId = data.nodeId;
                     break;
                  }
                  if(eventInfo.SonType == 3)
                  {
                     _loc2_ = LanguageMgr.GetTranslation("active.expback.frame.selectbtntxt");
                     _loc3_ = LanguageMgr.GetTranslation("ChristmasSnowymistMapItem.message.txt4",eventInfo.Para1);
                     SharedManagerHelper.ins.needAlert("ChristmasSnowymistFrame_clickHandler2",send,_loc2_,_loc3_);
                     break;
                  }
                  if(eventInfo.SonType == 4)
                  {
                     send();
                     break;
                  }
                  if(eventInfo.SonType == 5)
                  {
                     _loc2_ = LanguageMgr.GetTranslation("active.expback.frame.selectbtntxt");
                     _loc3_ = LanguageMgr.GetTranslation("ChristmasSnowymistMapItem.message.txt5",eventInfo.Para1);
                     SharedManagerHelper.ins.needAlert("ChristmasSnowymistFrame_clickHandler3",send,_loc2_,_loc3_);
                  }
               }
         }
      }
      
      private function sendClick() : void
      {
         if(!data)
         {
            return;
         }
         if(model.selfPlayer.energy < actionNum)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChristmasSnowymistMapItem.sendClick.txt1",actionNum));
            return;
         }
         MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChristmasSnowymistMapItem.sendClick.txt2",actionNum));
         ChristmasManager.instance.opRequest(22,data.nodeId);
      }
      
      private function send() : void
      {
         if(eventInfo.SonType == 3 && model.selfPlayer.myPoint < eventInfo.Para1)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChristmasSnowymistMapItem.sendNPC.txt"));
            return;
         }
         if(eventInfo.SonType == 5 && model.selfSnowyMist.teamPoint < eventInfo.Para1)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChristmasSnowymistMapItem.sendBoss.txt"));
            return;
         }
         ChristmasManager.instance.opRequest(22,data.nodeId);
      }
      
      private function get actionNum() : int
      {
         return ConfigInfoManager.instance.christmasActionPower;
      }
      
      public function refreshView() : void
      {
         if(!data)
         {
            return;
         }
         _icon.visible = false;
         _txt.text = "";
         _mask.visible = false;
         switch(itemState)
         {
            case 0:
               _bg.setFrame(1);
               break;
            case 1:
               _bg.setFrame(2);
               break;
            case 2:
               _icon.visible = true;
               _icon.setFrame(eventInfo.SonType);
               if(eventInfo.SonType == 3 || eventInfo.SonType == 5)
               {
                  _txt.text = eventInfo.Para1.toString();
               }
               _bg.setFrame(3);
               _mask.visible = true;
               break;
            case 3:
               _icon.visible = true;
               _icon.setFrame(eventInfo.SonType);
               if(eventInfo.SonType == 3 || eventInfo.SonType == 5)
               {
                  _txt.text = eventInfo.Para1.toString();
               }
               _bg.setFrame(2);
         }
      }
      
      private function get itemState() : int
      {
         var _loc1_:int = 0;
         switch(int(data.state))
         {
            case 0:
            case 1:
            case 3:
               _loc1_ = int(data.state);
               break;
            case 2:
               if(eventInfo.SonType == 5 && !model.selfPlayer.isBossReward)
               {
                  _loc1_ = 3;
               }
               else
               {
                  _loc1_ = 2;
               }
         }
         return _loc1_;
      }
      
      private function get data() : SnowyMistMapMsg
      {
         return model.selfSnowyMist.map[_index];
      }
      
      private function get eventInfo() : ChristmasActivitiesTempInfo
      {
         return TempleteManager.instance.christmasActivitiesTempCate.getTemplateByID(data.eventId);
      }
      
      private function get model() : ChristmasModel
      {
         return ChristmasManager.instance.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeObject(_mask);
         _mask = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

