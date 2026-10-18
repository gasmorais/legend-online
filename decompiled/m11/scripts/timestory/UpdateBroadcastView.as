package timestory
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.manager.BaseManager;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class UpdateBroadcastView extends Sprite implements Disposeable
   {
      
      private var _back:MovieClip;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _content:Component;
      
      private var _updateTitleBg:Bitmap;
      
      private var _updateContent:Bitmap;
      
      private var _dateAsset:Bitmap;
      
      private var _updateDate:FilterFrameText;
      
      private var _updatePreTitleBg:Bitmap;
      
      private var _updatePre:Bitmap;
      
      private var _titleSp1:Sprite;
      
      private var _titleSp2:Sprite;
      
      private var _contain:VBox;
      
      private var _itemArr1:Array;
      
      private var _itemArr2:Array;
      
      public function UpdateBroadcastView()
      {
         super();
         initView();
         refreshView();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatCustomObject("timestory.UpdateBroadCastBack");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("timestory.UpdateBroadCastScroll");
         _updateDate = ComponentFactory.Instance.creatComponentByStylename("timestory.UpdateBroadCastDate");
         _dateAsset = ComponentFactory.Instance.creatBitmap("asset.broadcast.UpdateDateAsset");
         _updateTitleBg = ComponentFactory.Instance.creatBitmap("asset.broadcast.UpdateTitleBg");
         _updateContent = ComponentFactory.Instance.creatBitmap("asset.broadcast.UpdateContentAsset");
         _updatePre = ComponentFactory.Instance.creatBitmap("asset.broadcast.UpdatePreAsset");
         _updatePreTitleBg = ComponentFactory.Instance.creatBitmap("asset.broadcast.UpdateTitleBg");
         _contain = new VBox();
         _contain.spacing = 10;
         addChild(_back);
         addChild(_scrollPanel);
         _titleSp1 = new Sprite();
         _titleSp2 = new Sprite();
         _itemArr1 = [];
         _itemArr2 = [];
         _titleSp1.addChild(_updateTitleBg);
         _titleSp1.addChild(_updateContent);
         _titleSp1.addChild(_dateAsset);
         _titleSp1.addChild(_updateDate);
         _titleSp2.addChild(_updatePreTitleBg);
         _titleSp2.addChild(_updatePre);
         _scrollPanel.setView(_contain);
      }
      
      private function refreshView() : void
      {
         var _loc1_:String = null;
         var _loc4_:* = null;
         var _loc2_:Sprite = null;
         var _loc5_:FilterFrameText = null;
         var _loc3_:Sprite = null;
         var _loc10_:FilterFrameText = null;
         var _loc6_:XML = BaseManager.instance.updateBroadcastContent;
         if(!_loc6_)
         {
            return;
         }
         try
         {
            _updateDate.text = _loc6_..time[0].toString();
         }
         catch(e:Error)
         {
            _loc1_ = LanguageMgr.GetTranslation("yishi.view.UpdateBroadCastFrame.Alert");
            MessageTipManager.instance().show(_loc1_);
            dispose();
            return;
         }
         var _loc7_:String = "";
         var _loc9_:String = "";
         var _loc8_:RegExp = /\/n/g;
         for each(_loc4_ in _loc6_.curContent..item)
         {
            if(_loc4_)
            {
               _loc2_ = new Sprite();
            }
            _loc5_ = ComponentFactory.Instance.creatComponentByStylename("timestory.UpdateBroadCastContent");
            if(!StringHelper.isNullOrEmpty(_loc4_.content.text()))
            {
               if(!StringHelper.isNullOrEmpty(_loc4_.title.text()))
               {
                  _loc7_ = "<font color=\'#fef347\'><textformat leading=\'7px\'>" + _loc4_.title.text() + "</textformat></font>\n";
               }
               _loc7_ = _loc7_ + "<font color=\'#e4d9ba\'><textformat leading=\'7px\' blockIndent=\'13em\'>" + _loc4_.content.text() + "</textformat></font>\n";
            }
            else if(!StringHelper.isNullOrEmpty(_loc4_.title.text()))
            {
               _loc7_ = "<font color=\'#fef347\'><textformat leading=\'7px\'>" + _loc4_.title.text() + "</textformat></font>\n";
            }
            _loc7_ = _loc7_.replace(_loc8_,"<br/>");
            _loc5_.htmlText = _loc7_;
            _loc5_.height = _loc5_.textHeight + 4;
            _loc2_.addChild(_loc5_);
            _itemArr1.push(_loc2_);
         }
         if(!StringHelper.isNullOrEmpty(_loc7_))
         {
            _contain.addChild(_titleSp1);
            for each(_loc2_ in _itemArr1)
            {
               _contain.addChild(_loc2_);
            }
         }
         for each(_loc4_ in _loc6_.nextContent..item)
         {
            if(_loc4_)
            {
               _loc3_ = new Sprite();
            }
            _loc10_ = ComponentFactory.Instance.creatComponentByStylename("timestory.UpdateBroadCastContent");
            if(!StringHelper.isNullOrEmpty(_loc4_.content.text()))
            {
               if(!StringHelper.isNullOrEmpty(_loc4_.title.text()))
               {
                  _loc9_ = "<font color=\'#fef347\'><textformat leading=\'7px\'>" + _loc4_.title.text() + "</textformat></font>\n";
               }
               _loc9_ = _loc9_ + "<font color=\'#e4d9ba\'><textformat leading=\'7px\' blockIndent=\'13em\'>" + _loc4_.content.text() + "</textformat></font>\n";
            }
            else if(!StringHelper.isNullOrEmpty(_loc4_.title.text()))
            {
               _loc9_ = "<font color=\'#fef347\'><textformat leading=\'7px\'>" + _loc4_.title.text() + "</textformat></font>\n";
            }
            _loc9_ = _loc9_.replace(_loc8_,"<br/>");
            _loc10_.htmlText = _loc9_;
            _loc10_.height = _loc10_.textHeight + 4;
            _loc3_.addChild(_loc10_);
            _itemArr2.push(_loc3_);
         }
         if(!StringHelper.isNullOrEmpty(_loc9_))
         {
            _contain.addChild(_titleSp2);
            for each(_loc3_ in _itemArr2)
            {
               _contain.addChild(_loc3_);
            }
         }
         _scrollPanel.invalidateViewport();
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_dateAsset);
         _dateAsset = null;
         ObjectUtils.disposeObject(_updateDate);
         _updateDate = null;
         ObjectUtils.disposeObject(_updateContent);
         _updateContent = null;
         ObjectUtils.disposeObject(_updatePre);
         _updatePre = null;
         ObjectUtils.disposeObject(_titleSp1);
         _titleSp1 = null;
         ObjectUtils.disposeObject(_titleSp2);
         _titleSp2 = null;
         ObjectUtils.disposeObject(_itemArr1);
         _itemArr1 = null;
         ObjectUtils.disposeObject(_itemArr2);
         _itemArr2 = null;
      }
   }
}

