package child.equip
{
   import bag.datas.GoodsSonType;
   import bag.helper.GoodsCheck;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.children.ChildSender;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.NotificationManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.frame.ConfirmSellFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildGoodsItemMenu extends Sprite implements Disposeable
   {
      
      private var _currentItem:BaseItemView;
      
      private var _sellBtn:TextButton;
      
      private var _moveBtn:TextButton;
      
      private var _vBox:VBox;
      
      private var _showMuti:Boolean;
      
      public function ChildGoodsItemMenu(param1:BaseItemView, param2:Boolean = true)
      {
         super();
         _currentItem = param1;
         _showMuti = param2;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _sellBtn = ComponentFactory.Instance.creatComponentByStylename("core.UseButton");
         _sellBtn.text = LanguageMgr.GetTranslation("cell.view.ChildsItemMenu.sell");
         _moveBtn = ComponentFactory.Instance.creatComponentByStylename("core.MoveButton");
         _moveBtn.text = LanguageMgr.GetTranslation("cell.view.ChildsItemMenu.move");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("core.GoodsItemMenuContain");
         _vBox.addChild(_sellBtn);
         _vBox.addChild(_moveBtn);
         addChild(_vBox);
      }
      
      private function initEvent() : void
      {
         if(_sellBtn)
         {
            _sellBtn.addEventListener("click",__sellBtnHandler);
         }
         if(_moveBtn)
         {
            _moveBtn.addEventListener("click",__moveHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_sellBtn)
         {
            _sellBtn.removeEventListener("click",__sellBtnHandler);
         }
         if(_moveBtn)
         {
            _moveBtn.removeEventListener("click",__moveHandler);
         }
      }
      
      private function __sellBtnHandler(param1:Event) : void
      {
         var _loc6_:Boolean = false;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc9_:ConfirmSellFrame = null;
         var _loc8_:String = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc7_:String = null;
         if(_currentItem && _currentItem.data)
         {
            _loc4_ = int(_currentItem.data.templateInfo.Profile);
            if(GoodsSonType.isPreciousGoods(_currentItem.data))
            {
               _loc6_ = true;
            }
            if(_loc6_)
            {
               _loc5_ = int(_currentItem.data.templateInfo.SellGold);
               _loc9_ = ComponentFactory.Instance.creatComponentByStylename("core.ConfirmSellFrame");
               _loc8_ = LanguageMgr.GetTranslation("armyII.viewII.ItemSellView.sellchildequipGoodsHtml",GoodsSonType.getColorByProfile(_loc4_),_currentItem.data.templateInfo.TemplateName,GoodsCheck.getChildSellGold(_currentItem.data)) + "\n" + LanguageMgr.GetTranslation("yishi.view.ConfirmSellFrame.content.htmlText02") + "<font color=\'#01ccff\'>[YES]</font>" + LanguageMgr.GetTranslation("cell.view.starbag.StarBagCell.confirmComposeTip2");
               _loc9_.show(_loc8_,_currentItem.data,__alertResponse2);
            }
            else
            {
               _loc2_ = LanguageMgr.GetTranslation("public.confirm");
               _loc3_ = LanguageMgr.GetTranslation("public.cancel");
               _loc7_ = LanguageMgr.GetTranslation("public.prompt");
               _loc8_ = LanguageMgr.GetTranslation("armyII.viewII.ItemSellView.sellchildequipGoodsHtml",GoodsSonType.getColorByProfile(_loc4_),_currentItem.data.templateInfo.TemplateName,GoodsCheck.getChildSellGold(_currentItem.data));
               SimpleAlertHelper.instance.data = [__alertResponse,_currentItem.data];
               SimpleAlertHelper.instance.popAlerFrame(_loc7_,_loc8_,_loc2_,_loc3_,false,true);
            }
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("armyII.viewII.ItemSellView.sellchildequipGoodsHtml2"));
         }
         dispose();
      }
      
      private function __alertResponse2(param1:Boolean, param2:Boolean, param3:GoodsInfo) : void
      {
         if(param1)
         {
            if(param3.join1 > 0 || param3.join2 > 0 || param3.join3 > 0 || param3.join4 > 0)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("child.childbagcellclick"));
               return;
            }
            ChildSender.sellEquip(param3.pos,param3.id,param3.count);
         }
      }
      
      private function __alertResponse(param1:Boolean, param2:Boolean, param3:GoodsInfo, param4:Object = null) : void
      {
         if(param1)
         {
            if(param3.join1 > 0 || param3.join2 > 0 || param3.join3 > 0 || param3.join4 > 0)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("child.childbagcellclick"));
               return;
            }
            ChildSender.sellEquip(param3.pos,param3.id,param3.count);
         }
      }
      
      private function __moveHandler(param1:MouseEvent) : void
      {
         if(_currentItem && _currentItem.data)
         {
            NotificationManager.instance.sendNotification("DRAG_ITEM_BagNotic",[_currentItem,_currentItem.data.count]);
         }
         dispose();
      }
      
      public function dispose() : void
      {
         removeEvent();
         _currentItem = null;
         StageReferance.stage.focus = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         ObjectUtils.disposeObject(_currentItem);
         _currentItem = null;
         ObjectUtils.disposeObject(_sellBtn);
         _sellBtn = null;
         ObjectUtils.disposeObject(_moveBtn);
         _moveBtn = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
      }
   }
}

