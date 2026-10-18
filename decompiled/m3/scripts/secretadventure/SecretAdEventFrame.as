package secretadventure
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.secret.SecretEventInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.SecretEventTemplate;
   import yishi.datas.templates.SecretMapDataTemplate;
   import yishi.manager.SecretAdventerManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class SecretAdEventFrame extends Frame
   {
      
      private var _desTxt:FilterFrameText;
      
      private var _confirmBtn:BaseButton;
      
      private var _rewardTitle:Bitmap;
      
      private var _rewardBox:HBox;
      
      private var _temp:SecretEventTemplate;
      
      private var _info:SecretEventInfo;
      
      private var _isNear:Boolean;
      
      private var _mapDataId:int;
      
      public function SecretAdEventFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _desTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretadventure.nodeDesTxt");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("ui.secretad.eventConfirmBtn");
         _rewardBox = ComponentFactory.Instance.creatCustomObject("ui.secretadventure.eventReward");
         addToContent(_desTxt);
         addToContent(_rewardBox);
         addToContent(_confirmBtn);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _confirmBtn.addEventListener("click",clickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _confirmBtn.removeEventListener("click",clickHandler);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:Array = [10,14,15];
         if(_isNear && _loc2_.indexOf(_temp.FunType) != -1)
         {
            if(_temp.FunType == 14)
            {
               if(_info.state == 0)
               {
                  SecretAdventerManager.Instance.opEvent(_info.mapDataId,_info.nodeId);
               }
               else
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("secret.trans.open"));
               }
            }
            else
            {
               SecretAdventerManager.Instance.opEvent(_info.mapDataId,_info.nodeId);
            }
         }
         dispose();
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
         ObjectUtils.disposeObject(_desTxt);
         _desTxt = null;
         ObjectUtils.disposeObject(_confirmBtn);
         _confirmBtn = null;
         ObjectUtils.disposeObject(_rewardBox);
         _rewardBox = null;
         ObjectUtils.disposeObject(_rewardTitle);
         _rewardTitle = null;
         super.dispose();
         _temp = null;
      }
      
      public function show(param1:Array) : void
      {
         _info = param1[0];
         _isNear = param1[1];
         _mapDataId = param1[2];
         refreshView();
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function refreshView() : void
      {
         var _loc5_:SecretMapDataTemplate = null;
         var _loc7_:Array = null;
         var _loc3_:BaseItemView = null;
         var _loc8_:int = 0;
         var _loc2_:String = null;
         var _loc1_:Array = null;
         var _loc6_:GoodsInfo = null;
         var _loc9_:Array = null;
         var _loc4_:int = 0;
         _temp = TempleteManager.instance.secretEventCate.getEventTempInfo(_info.eventId);
         if(_temp)
         {
            if(_temp.FunType == 10)
            {
               _loc5_ = TempleteManager.instance.secretSonDataCate.getTempInfo(_mapDataId);
               if(_loc5_)
               {
                  titleText = _loc5_.TaskTitle;
                  _desTxt.text = _loc5_.Introduction;
               }
               if(_info.params)
               {
                  _loc7_ = _info.params.split("@");
                  _rewardBox.beginChanges();
                  _loc9_ = [];
                  _loc4_ = 0;
                  while(_loc4_ < _loc7_.length)
                  {
                     _loc2_ = _loc7_[_loc4_];
                     _loc1_ = _loc2_.split("#");
                     _loc8_ = int(_loc1_[0]);
                     if(_loc9_.indexOf(_loc8_) == -1)
                     {
                        _loc9_.push(_loc8_);
                        _loc6_ = new GoodsInfo();
                        _loc6_.templateId = _loc8_;
                        _loc3_ = ComponentFactory.Instance.creatCustomObject("core.BaseItemView");
                        _loc3_.data = _loc6_;
                        _rewardBox.addChild(_loc3_);
                     }
                     _loc4_++;
                  }
                  _rewardBox.commitChanges();
               }
               if(!_rewardTitle)
               {
                  _rewardTitle = ComponentFactory.Instance.creatBitmap("asset.secretad.rewardTitle");
               }
               addToContent(_rewardTitle);
               _confirmBtn.y = 130;
               this.height = _confirmBtn.y + _confirmBtn.height + 50;
            }
            else
            {
               titleText = _temp.Name;
               _desTxt.text = _temp.Description;
               _desTxt.height = _desTxt.numLines * 20;
               _confirmBtn.y = _desTxt.y + _desTxt.height + 10;
               this.height = _confirmBtn.y + _confirmBtn.height + 50;
            }
         }
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

