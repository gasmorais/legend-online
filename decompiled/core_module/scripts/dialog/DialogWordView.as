package dialog
{
   import com.greensock.text.SplitTextField;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import dialog.data.NoviceDialogueXml;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import managers.MarryManager;
   import map.campaign.CampaignManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.WorldBossHelper;
   
   public class DialogWordView extends Sprite
   {
      
      private var _dialogText:FilterFrameText;
      
      private var _stf:SplitTextField;
      
      private var _speakEndHandler:Function;
      
      private var _speakHandler:DialogWordHandler;
      
      private var _txtWidth:Number;
      
      private var _nameText:FilterFrameText;
      
      private var _name:String;
      
      private var _sentence:String;
      
      private var _guardImge:Bitmap;
      
      public function DialogWordView()
      {
         super();
         _dialogText = ComponentFactory.Instance.creatComponentByStylename("core.novice.DialogText");
         _txtWidth = _dialogText.width;
         addChild(_dialogText);
         _stf = new SplitTextField();
      }
      
      public function setSentence(param1:String, param2:Function = null, param3:String = "") : void
      {
         _sentence = param1;
         _speakEndHandler = param2;
         _name = param3;
         addNameTxt();
         addSentenceTxt();
      }
      
      private function speakEndHandler() : void
      {
         if(_speakEndHandler != null)
         {
            _speakEndHandler();
         }
      }
      
      private function addNameTxt() : void
      {
         if(_nameText && _nameText.parent)
         {
            removeChild(_nameText);
            _nameText.dispose();
            _nameText = null;
         }
         if(_name && _name != "")
         {
            _nameText = ComponentFactory.Instance.creatComponentByStylename("core.novice.DialogNameText");
            _nameText.text = _name + ":";
            addChild(_nameText);
         }
      }
      
      private function addSentenceTxt() : void
      {
         var _loc1_:Object = null;
         _dialogText.y = 33;
         _dialogText.width = _txtWidth;
         var _loc2_:RegExp = /&%/g;
         if(PlayerManager.instance.currentPlayerModel.playerInfo.nickName == PlayerManager.instance.currentPlayerModel.userInfo.userId + "$")
         {
            _sentence = _sentence.replace(_loc2_,LanguageMgr.GetTranslation("public.nickName"));
         }
         else
         {
            _sentence = _sentence.replace(_loc2_,PlayerManager.instance.currentPlayerModel.playerInfo.nickName);
         }
         if(WorldBossHelper.checkWedding(CampaignManager.instance.mapId) && MarryManager.instance.model.isWeddingMaster)
         {
            _loc2_ = />>/g;
            _sentence = _sentence.replace(_loc2_,"</font>");
            _loc2_ = /<</g;
            _sentence = _sentence.replace(_loc2_,"<font color=\'#ff5ca9\'>");
         }
         _dialogText.htmlText = "    " + _sentence;
         updatePos();
         _stf.source = _dialogText;
         if(_sentence == NoviceDialogueXml.xml..story[0]..item[1].@txt)
         {
            if(_guardImge)
            {
               if(_guardImge.parent)
               {
                  _guardImge.parent.removeChild(_guardImge);
               }
               _guardImge.bitmapData.dispose();
               _guardImge = null;
            }
            _guardImge = ComponentFactory.Instance.creatBitmap("asset.novice.GuardImage");
            _loc1_ = CampaignManager.instance.controller.getArmyView(CampaignManager.instance.mapModel.selfMemberData);
            _guardImge.x = (_loc1_.width - _guardImge.width) / 2;
            _guardImge.y = -160;
            _loc1_.addChild(_guardImge);
         }
         _speakHandler = new DialogWordHandler(_stf,speakEndHandler);
         _speakHandler.start();
      }
      
      public function completeSpeak() : Boolean
      {
         return _speakHandler.canStop();
      }
      
      public function refreshSize(param1:Number) : void
      {
         if(Math.abs(_txtWidth - param1) < 10)
         {
            return;
         }
         _txtWidth = param1;
         _dialogText.width = param1;
         updatePos();
         _dialogText.htmlText = "";
         _stf.source = _dialogText;
      }
      
      private function updatePos() : void
      {
      }
      
      public function dispose() : void
      {
         if(_speakHandler)
         {
            _speakHandler.dispose();
         }
         _speakHandler = null;
         _speakEndHandler = null;
         if(_guardImge && _guardImge.parent)
         {
            _guardImge.parent.removeChild(_guardImge);
            ObjectUtils.disposeObject(_guardImge);
         }
         _guardImge = null;
         if(_dialogText)
         {
            if(_dialogText.parent)
            {
               removeChild(_dialogText);
            }
            _dialogText.dispose();
         }
         _dialogText = null;
         if(_nameText)
         {
            _nameText.dispose();
         }
         _nameText = null;
         if(_stf)
         {
            _stf.destroy();
         }
         _stf = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

